require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'mbta'

get '/mbta/create' do
  erb :mbta_form
end

post '/mbta/new' do
  erb :mbta
end