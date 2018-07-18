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
    erb :'users/login'
  end
end






end #of class
