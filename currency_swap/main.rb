require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require_relative 'database_config'
require_relative 'models/user'
require_relative 'models/post'
require_relative 'models/user_rating'

enable :sessions

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in? # w/? return boolean
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
  post.post_code = params[:post_code]
  post.phone_number = params[:phone_number]
  post.save
  if post.save
    redirect '/'
  else
    erb :new
  end
end

post '/posts/list' do
  erb :selected_posts
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
