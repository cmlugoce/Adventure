class UsersController < ApplicationController

 get '/register' do
   if logged_in?

     redirect '/trails'

   else
     erb :'/users/register'
   end
 end






end #of class
