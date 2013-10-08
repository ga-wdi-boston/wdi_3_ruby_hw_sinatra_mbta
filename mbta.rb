require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
	@heading = "MBTA Trip Planner"
	@red_stations = %w(Alewife Davis Porter Harvard Central Kendall Park South\ Station)
	@green_stations = %w(Haymarket Government\ Center Park Boylston Arlington Copley)
	@orange_stations = %w(North\ Station Haymarket Park State Downtown\ Crossing Chinatown Back\ Bay Forest\ Hills)
	erb :form
end

post '/create' do
	
	@heading = "MBTA Trip Planner Results"

	@red_stations = %w(Alewife Davis Porter Harvard Central Kendall Park South\ Station)
	@green_stations = %w(Haymarket Government\ Center Park Boylston Arlington Copley)
	@orange_stations = %w(North\ Station Haymarket Park State Downtown\ Crossing Chinatown Back\ Bay Forest\ Hills)

	@subway_lines = {"Red" => @red_stations, "Green" => @green_stations, "Orange" => @orange_stations}

	@start_station = params[:start].scan(/: (\w+ *\w*)/).flatten[0]
	@end_station = params[:end].scan(/: (\w+ *\w*)/).flatten[0]
	@start_line = params[:start].scan(/\w+/)[0]
	@end_line = params[:end].scan(/\w+/)[0]

	if @start_line == @end_line
		a = @subway_lines[@start_line].index(@start_station)
		b = @subway_lines[@end_line].index(@end_station)
		@trip_distance = (a - b).abs
	else
		a = (@subway_lines[@start_line].index(@start_station) - @subway_lines[@start_line].index("Park")).abs
		b = (@subway_lines[@end_line].index(@end_station) - @subway_lines[@end_line].index("Park")).abs
		@trip_distance = a + b
	end
  erb :mbta
end
