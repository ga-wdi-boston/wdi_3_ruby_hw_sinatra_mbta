require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

mbta = { 
	red: ["south_station", "park_st", "kendall", "central", "harvard", "porter", "davis", "alewife"], 
	orange: ["north_station", "haymarket_orange", "park_st", "state", "downtown_crossing", "chinatown", "back_bay", "forest_hills"], 
	green: ["haymarket_green", "government_center", "park_st", "bolyston", "arlington", "copley"] 
	}

def distance_trip(mbta_hash, start_line, end_line, start_stop, end_stop)
	if start_line == end_line
		first_leg_dist =mbta_hash[start_line.to_sym].index(start_stop).to_i
		second_leg_dist =mbta_hash[end_line.to_sym].index(end_stop).to_i
		distance = (second_leg_dist - first_leg_dist).abs
	else 
		first_leg = mbta_hash[start_line.to_sym].index(start_stop).to_i
		first_to_park = mbta_hash[start_line.to_sym].index('park_st').to_i
		second_leg = mbta_hash[end_line.to_sym].index(end_stop).to_i
		second_to_park = mbta_hash[end_line.to_sym].index('park_st').to_i
		first_dist = (first_leg - first_to_park).abs
		second_dist = (second_leg - second_to_park).abs
		distance = second_dist + first_dist
	end
	return distance
end

get '/MBTA/new' do
	# Access drop-down form of MBTA Stations
	erb :drop_down
end

post '/MBTA/create' do
	start_stop, start_line = params[:Begin_trip].split('--')
	end_stop, end_line = params[:End_trip].split('--')
	@distance = distance_trip(mbta, start_line, end_line, start_stop, end_stop)
	erb :result
end




