require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
set :server, 'webrick'

# Define arrays for all three T lines and put them into a larger array. 
red = ["South Station", "Park Street", "Kendall", "Central", "Harvard", "Porter", "Davis", "Alewife"]
orange = ["North Station", "Haymarket", "Park Street", "State", "Downtown Crossing", "Chinatown", "Back Bay", "Forest Hills"]
green = ["Copley", "Arlington", "Boylston", "Park Street", "Government Center", "Haymarket"]
lines = [red, orange, green]

# Define constants for Park Street array position on each line. 
PSRED = 1
PSORANGE = 2
PSGREEN = 3

# Define methods. 
def sameline(x, y)
	if x == y
		return true
	else
		return false
	end
end

#Method to equate the startline with the appropriate array. 
def startarray(startline)
	if startline == "red"
		return 0
	elsif startline == "orange"
		return 1
	else
		return 2
	end
end

#Method to equate the endline with the appropriate array.
def endarray(endline)
	if endline == "red"
		return 0
	elsif endline == "orange"
		return 1
	else
		return 2
	end
end

get '/mbta/new' do 
	erb :mbta_form

end

post '/mbta/ride' do
	startpoint = params[:startpoint]
	endpoint = params[:endpoint]
	@startline = startpoint.split(",")[0]
	@startstop = startpoint.split(",")[1]
	@endline = endpoint.split(",")[0]
	@endstop = endpoint.split(",")[1]

	if sameline(@startline, @endline) == true

		if startarray(@startline) == 0
			array = red
		elsif startarray(@startline) == 1
			array = orange
		else
			array = green
		end

		start = array.index(@startstop)

		finish = array.index(@endstop)

		@trip_length = (start.to_i - finish.to_i).abs
		
	else
		
		if startarray(@startline) == 0
			array_1 = red
			park_1 = PSRED
		elsif startarray(@startline) == 1
			array_1 = orange
			park_1 = PSORANGE
		else
			array_1 = green
			park_1 = PSGREEN
		end

			start = array_1.index(@startstop)

			trip_length_1 = (start.to_i - park_1).abs

		if endarray(@endline) == 0
			array_2 = red
			park_2 = PSRED
		elsif endarray(@endline) == 1
			array_2 = orange
			park_2 = PSORANGE
		else
			array_2 = green
			park_2 = PSGREEN
		end

			finish = array_2.index(@endstop)

			trip_length_2 = (park_2 - finish.to_i).abs

		@trip_length = trip_length_1 + trip_length_2
	end

	erb :mbta_ride
end