require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base

   use Rack::Flash
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
     @current_user ||= User.find_by(id: session[:id])
   end
 end

end
