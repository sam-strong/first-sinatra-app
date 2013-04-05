# Remember to run the server when testing locally
# by going shotgun sinatra-app.rb
# then go to localhost:9393 in your browser
#
require 'bundler/setup'
require 'sinatra'
require 'sinatra/contrib'
require 'data_mapper'
require './lib/contact'
require './lib/comment'

# for templates uncomment the line below
require 'erb'
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/users")
#require 'post
DataMapper::Model.raise_on_save_failure = true
DataMapper.finalize
DataMapper.auto_upgrade!


get '/' do
  # This will be your default route
  @names = ["tom","dick","harry"]
  erb :index
  #haml :list, :locals => { :cs => Contacts.all}
end

get '/other' do
	@names = ["this","is","not","a","list","of","names","anymore"]
	erb :name
end

get '/users_form'do
	erb :partial
end

get '/comment_form'do
  erb :comment_form
end
# get '/users' do
# 	@name = contact.get
#     erb :users
# end

post '/users' do
	contact = Contact.new
  puts params
	contact.name = params["firstname"]
	contact.age = params["age"]
	contact.sex = params["sex"]
#  contact.twitter = params["twitter"]
	contact.save
  @contact_id=contact.id
  puts @contact_id
  redirect "/users/#{@contact_id}"
end

get '/users' do
  @contacts = Contact.all
  erb :users
end

get '/users/:id' do
"hello"
   @contacts = Contact.all
   @user_id = params[:id]
   puts params[:id]
   erb :user_id
end

post '/comments' do
  comment = Comment.new
  comment.note = params["note"]
  comment.name = params["firstname"]
  comment.time = Time.now
  comment.contact_id = params[@contact_id]
  comment.save
  redirect '/comments'
end

get '/comments' do
  @comments = Comment.all
  puts @comments.inspect
  erb :comments
end


# Try adding some other routes

# Test at <appname>.heroku.com (you'll need to create your app first!)