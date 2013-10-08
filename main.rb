require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'mbta'

get '/trip' do
	
end

get '/trip/show' do
	erb :trip_show #same as other get
end

get '/trip/new' do
	erb :user_new #need to make this erb file
end

post '/trip/create' do
	erb :trip_show #same as get above
end