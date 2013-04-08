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

get '/'do
  erb :welcome
end

get '/user_form' do
  erb :user_form
end

post '/user_entered' do
  contact = Contact.new
  contact.name = params["firstname"]
  contact.age = params["age"]
  contact.sex = params["sex"]
  #  contact.twitter = params["twitter"]
  contact.save
  @contact_id=contact.id
  redirect "/user_entered/#{@contact_id}"
end

get '/user_entered/:id' do
  @user_id = params[:id]
  @contact = Contact.get(params[:id])
  @comments = Contact.get(params[:id]).comment
  erb :user
end

get '/users/:id' do
  @contacts = Contact.all
  @user_id = params[:id]
  erb :users
end

get '/comment_form/:id' do
  @user_id = params[:id]
  erb :comment_form
end

post '/comment_form/:id'do
  comment = Comment.new
  comment.note = params["note"]
  comment.time = Time.now
  comment.contact = Contact.get(params[:id])
  comment.name = Contact.get(params[:id]).name
  comment.save
  redirect '/comments'
end

get '/user_comment/edit' do
  @user = params[:u]
  @comment = params[:c]
  erb :user_comment
end

get '/user_comment/remove' do
  @user = params[:u]
  @comment = params[:c]
  erb :user_comment
end





# post '/comments' do
#   comment = Comment.new
#   comment.note = params["note"]
#   comment.name = params["firstname"]
#   comment.time = Time.now
#   comment.contact_id = params[@contact_id]
#   comment.save
#   redirect '/comments'
# end

get '/comments' do
  @comments = Comment.all
  erb :comments
end


# Try adding some other routes

# Test at <appname>.heroku.com (you'll need to create your app first!)
