class UsersController < ApplicationController

 get '/register' do
   if logged_in?

     redirect '/trails'

   else
     erb :'/users/register'
   end
 end


 post '/register' do
   @user = User.new(params)

  if  @user.save
    @user.save
   session[:id] = @user.id
   redirect '/trails'

 else
   redirect '/register'
 end
end







end #of class
