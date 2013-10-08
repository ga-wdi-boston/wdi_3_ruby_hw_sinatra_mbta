require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
	@red_stations = %w(Alewife Davis Porter Harvard Central Kendall Park South_Station)
	@green_stations = %w(Haymarket Government_Center Park Boylston Arlington Copley)
	@orange_stations = %w(North_Station Haymarket Park State Downtown_Crossing Chinatown Back_Bay Forest_Hills)
	erb :form
end

post '/create' 
	
	binding.pry

	@red_stations = %w(Alewife Davis Porter Harvard Central Kendall Park South_Station)
	@green_stations = %w(Haymarket Government_Center Park Boylston Arlington Copley)
	@orange_stations = %w(North_Station Haymarket Park State Downtown_Crossing Chinatown Back_Bay Forest_Hills)

	@start_station = params[:start].scan(/: (\w+)/)
	@end_station = params[:end].scan(/: (\w+)/)
	@start_line = params[:start].scan(/\w+/)[0]
	@end_line = params[:end].scan(/\w+/)[0]

	if @start_line == @end_line
		case @start_line
		when "Red"
			a = @red_stations.index(@start_station)
			b = @red_stations.index(@end_station)
			@trip_distance = (a - b).abs
		when "Green"
			a = @green_stations.index(@start_station)
			b = @green_stations.index(@end_station)
			@trip_distance = (a - b).abs
		when "Orange"
			a = @orange_stations.index(@start_station)
			b = @orange_stations.index(@end_station)
			@trip_distance = (a - b).abs
		else
			"Error"
		end
	else
		
		case @start_line

		when "Red"
			a = (@red_stations.index(@start_station) - @red_stations.index("Park")).abs
		when "Green"
			a = (@green_stations.index(@start_station) - @green_stations.index("Park")).abs
		when "Orange"
			a = (@orange_stations.index(@start_station) - @orange_stations.index("Park")).abs
		else
			a = 100
		end

		case @end_line

		when "Red"
			b = (@red_stations.index(@end_station) - @red_stations.index("Park")).abs
		when "Green"
			b = (@green_stations.index(@end_station) - @green_stations.index("Park")).abs
		when "Orange"
			b = (@orange_stations.index(@end_station) - @orange_stations.index("Park")).abs
		else
			b = 900
		end

		@trip_distance = a + b
	end
  erb :mbta
end
