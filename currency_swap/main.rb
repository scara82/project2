require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require_relative 'database_config'
require_relative 'models/user'
require_relative 'models/post'
require_relative 'models/user_rating'
require_relative 'models/chat'

enable :sessions

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

end

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  erb :index
end

get '/users/new' do
  erb :new_user
end

post '/users' do
  user = User.new
  user.email = params[:email]
  user.password = params[:password]
  user.phone_number = params[:phone_number]
  user.id = params[:id]
  user.save
  if user.save
    redirect '/'
  else
    erb :new_user
  end
end

get '/posts/new' do
  erb :new
end

post '/posts' do
  post = Post.new
  post.curr_from = params[:curr_from]
  post.amount = params[:amount]
  post.curr_to = params[:curr_to]
  post.before_date = params[:before_date]
  post.city = params[:city]
  post.phone_number = params[:phone_number]
  post.comment = params[:comment]
  post.user_id = session[:user_id]
  post.save
  if post.save
    redirect '/'
  else
    erb :new
  end
end

get '/posts/list/new' do
  erb :selected_posts
end

post '/posts/list' do
  @posts = Post.where(curr_from: params['curr_to'], curr_to: params['curr_from'])
  erb :list
end

get '/posts/my_posts' do
  @posts = Post.where(user_id: session[:user_id])
  erb :my_posts
end

delete '/post/:id' do
  Post.find(params[:id]).destroy
  redirect '/'
end

get '/post/:id/edit' do
  @post = Post.find(params[:id])
  erb :edit
end

put '/post/:id' do
  post = Post.find(params[:id])
  post.curr_from = params[:curr_from]
  post.amount = params[:amount]
  post.curr_to = params[:curr_to]
  post.before_date = params[:before_date]
  post.city = params[:city]
  post.comment = params[:comment]
  post.phone_number = params[:phone_number]
  post.save
  redirect '/posts/my_posts'
end

post '/chat' do
  chat = Chat.new
  chat.body = params[:body]
  chat.post_id = params[:post_id]
  chat.sender_id = params[:sender_id]
  chat.receiver_id = params[:receiver_id]
  chat.date_msg = params[:date_msg]
  if chat.save
    redirect ""
  else
    erb :
  end
end

get '/session/new' do
  erb :login
end

post '/session' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/session/new'
end
