require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/trip' do
	erb :trip_new
end

get '/trip/show' do
	erb :trip_show
end

get '/trip/new' do
	erb :trip_new
end

post '/trip/create' do
	start_info = params[:home].split("-")
	end_info = params[:destination].split("-")

	@home = start_info[1]
	@home_line = start_info[0].to_sym
	@destination = end_info[1]
	@destination_line = end_info[0].to_sym

	MBTA = {
		red: ["south_station", "park_st", "kendall", "central", "harvard", "porter", "davis", "alewife"],
		green: ["haymarket_green", "government_center", "park_st", "boylston", "arlington", "copley"],
		orange: ["north_station", "haymarket", "park_st", "state", "downtown_crossing", "chinatown", "back_bay", "forest_hills"]
		}

		def calc_index(line, stop)
			return MBTA[line].index(stop).to_i
		end

		def same_line(home_line, home, destination_line, destination)
			home_index = calc_index(@home_line, @home)
			destination_index = calc_index(@destination_line, @destination)
			return (home_index - destination_index).abs
		end

		def diff_lines(home_line, home, destination_line, destination)
			home_index = calc_index(@home_line, @home)
			destination_index = calc_index(@destination_line, @destination)

			home_mid_point = calc_index(@home_line, "park_st")
			destination_mid_point = calc_index(@destination_line, "park_st")

			first_leg = (home_index - home_mid_point).abs.to_i
			second_leg = (destination_index - destination_mid_point).abs.to_i
			first_leg + second_leg
		end

		if @home_line == @destination_line
			@calc = same_line(@home_line, @home, @destination_line, @destination)
		else
			@calc = diff_lines(@home_line, @home, @destination_line, @destination)
		end

	erb :trip_show #same as get above
end