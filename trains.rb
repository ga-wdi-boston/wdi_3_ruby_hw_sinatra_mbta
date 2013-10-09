require 'sinatra'
require 'sinatra/reloader'
require 'pry'
set :server, 'webrick'


Train_routes = {"red line" => ["south st", "park st", "kendall", "central", "harvard", "porter", "davis", "alewife"], "green line" => ["haymarket green", "govt center", "park st", "boylston", "arlington", "copley"], "orange line" => ["north st", "haymarket orange", "park st", "state st", "downtown", "chinatown", "back bay", "forest hill"]}

def one_track_trip(start_line, start_stop, end_line, end_stop)
  newlist = []
    newlist = Train_routes.fetch(start_line)
    pos1 = newlist.index(start_stop)
    pos2 = newlist.index(end_stop)
    (pos1.to_i - pos2.to_i).abs
end

def two_track_trip(start_line, start_stop, end_line, end_stop)
  first_track = Train_routes.fetch(start_line)
  second_track = Train_routes.fetch(end_line)
  park = first_track.index("park st")
  start = first_track.index(start_stop)
  first_dist = (park.to_i - start.to_i).abs
  park2 = second_track.index("park st")
  start2 = second_track.index(end_stop)
  second_dist = (park2.to_i - start2.to_i).abs
  first_dist + second_dist
end

def one_or_two_lines(start_line, start_stop, end_line, end_stop)
  if start_line == end_line
    one_track_trip(start_line, start_stop, end_line, end_stop)
  else
    two_track_trip(start_line, start_stop, end_line, end_stop)
  end
end

def count_trip(start_line, start_stop, end_line, end_stop)
  if start_stop == end_stop
    "...well you should probably stop drinking on the train.  You are already at the stop you wish to travel to!"
  else
    one_or_two_lines(start_line, start_stop, end_line, end_stop)
  end
end

get '/user/new' do
  erb :train_new
end

post '/user/create' do
  start_line, start_stop =(@params[:origin_start]).split("-") 
  end_line, end_stop = (@params[:origin_stop]).split("-")
  @start = start_stop
  @line1 = start_line
  @stop = end_stop
  @line2 = end_line
  @answer = count_trip(start_line, start_stop, end_line, end_stop)
  erb :test_show
end