require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

mbta = { 
	red: ["south_station", "park_st", "kendall", "central", "harvard", "porter", "davis", "alewife"], 
	orange: ["north_station", "haymarket_orange", "park_st", "state", "downtown_crossing", "chinatown", "back_bay", "forest_hills"], 
	green: ["haymarket_green", "government_center", "park_st", "bolyston", "arlington", "copley"] 
	}

get '/MBTA/new' do
	# Access drop-down form of MBTA Stations
	erb :drop_down
end

# def one_line_trip(mbta_hash, start_line, end_line, start_stop, end_stop)
# 	first_leg_dist =mbta_hash[start_line.to_sym].index(start_stop).to_i
# 	second_leg_dist =mbta_hash[end_line.to_sym].index(end_stop).to_i
# 	return (second_leg_dist - first_leg_dist).abs
# end

# def two_line_trip(mbta_hash, start_line, end_line, start_stop, end_stop)
# 	first_leg = mbta_hash[start_line.to_sym].index(start_stop).to_i
# 	first_to_park = mbta_hash[start_line.to_sym].index('park_st').to_i
# 	second_leg = mbta_hash[end_line.to_sym].index(end_stop).to_i
# 	second_to_park = mbta_hash[end_line.to_sym].index('park_st').to_i
# 	first_dist = (first_leg - first_to_park).abs
# 	second_dist = (second_leg - second_to_park).abs
# 	return second_dist + first_dist
# end

# if start_line == end_line
# 	trip_stops = one_line_trip(mbta, start_line, end_line, start_stop, end_stop)
# 	p "Start at #{start_stop}, get off after #{trip_stops} stops at #{end_stop}. "
# else 
# 	trip_stops = two_line_trip(mbta, start_line, end_line, start_stop, end_stop)
# 	p "Start at #{start_stop} on the #{start_line} line. Transfer to the #{end_line} line at park st. station. Ride until #{end_stop} station. Your trip requires #{trip_stops} total stops."
# end