class UsersController < ApplicationController

 get '/register' do
   if logged_in?

     redirect '/trails'

   else
     erb :'/users/register'
   end
 end


 post '/register' do
   @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

  if  @user.save
    @user.save
   session[:id] = @user.id
   redirect '/trails'

 else
   flash[:message] = "Please fill up all the required fields"
   redirect '/register'
 end
end

get '/login' do
  if logged_in?
    redirect '/trails'

  else
    erb :'/users/login'
  end
end
 post '/login' do
   @user = User.find_by(:username => params[:username])
   if @user && @user.authenticate(params[:password])
     flash[:notice] = "Welcome, #{@user.username}."
     session[:id] = @user.id
     redirect '/trails'

   else
     flash[:message] = "Invalid password and/or username"
     redirect '/login'
   end
 end

get '/logout' do
  if logged_in?
    session.clear

    redirect '/login'
 else
  redirect '/'
end
end
get '/users/:slug' do
  @user = User.find_by_slug(params[:slug])
  @trails = @user.trails
erb :'/users/show'
end



end #of class
