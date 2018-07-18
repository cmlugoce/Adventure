class TrailsController < ApplicationController


 get 'trails/new' do
   if logged_in?
     erb :'/parks/new'

   else
     redirect '/login'
   end
 end

 get '/trails/:id/edit' do
   @trails = Trail.find(params[:id])

   if logged_in? && @trail.user == current_user
     erb :'/trails/edit'

   else
     redirect '/login'
   end
 end












end #of class
