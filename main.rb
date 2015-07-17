require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'mbta'

get '/mbta/create' do
  erb :mbta_form
end

post '/mbta/new' do
  @line_on, @start = params[:origin].split('/')
  @line_off, @stop = params[:destination].split('/')
  @total_stops = calculate_number_of_stops(@line_on, @start, @line_off, @stop)
  erb :mbta
end