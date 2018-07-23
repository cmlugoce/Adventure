require './config/environment'


class ApplicationController < Sinatra::Base

  register Sinatra::Flash
 require 'sinatra/flash'
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :home
  end

 helpers do
   def logged_in?
     !!current_user
   end
   def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end
 end

end
