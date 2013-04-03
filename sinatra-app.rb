# Remember to run the server when testing locally
# by going shotgun sinatra-app.rb
# then go to localhost:9393 in your browser
#
require 'bundler/setup'
require 'sinatra'
require 'sinatra/contrib'


# for templates uncomment the line below
require 'erb'



get '/' do
  # This will be your default route
  @names = ["tom","dick","harry"]
  erb :index
end

get '/other' do 
	@names = ["this","is","not","a","list","of","names","anymore"]
	erb :name
end

post 'users' do 
	@name = name
	

# Try adding some other routes

# Test at <appname>.heroku.com (you'll need to create your app first!)