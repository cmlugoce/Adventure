class TrailsController < ApplicationController


get '/trails' do
  if logged_in?
    @trails = Trail.all
    erb :'/users/index'

  else
    redirect '/login'

  end
end

post '/trails' do
  if logged_in?
    @trail = Trail.new(name: params[:name], location: params[:location], date: params[:date], notes: params[:notes], distance: params[:distance], user_id: session[:id] )
   if @trail.save
     @trail.save

     redirect '/trails'
   else
     redirect '/'
   end
 end


 get 'trails/new' do
   if logged_in?
     erb :'/parks/new'

   else
     redirect '/login'
   end
 end

 get '/trails/:id' do
   if logged_in?
     @trail = Trail.find_by_id(params[:id])
     erb :'/trails/show'

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

 patch '/trails/:id' do
   if params[:name] == "" || params[:location] == "" | params[:date] == ""
     flash[:message] = "Please fill out the required fields."
     redirect "/trails/#{{params[:id]}}/edit"
   else
     @trail = Trail.find(params[:id])
     @trail.update(name: params[:name], location: params[:location], date: params[:date], notes: params[:notes], distance: params[:distance])
   end
   redirect "/trails/#{@trail.id}"
 end


delete '/trails/:id/delete' do
  if logged_in? && current_user.trails.find_by(id: params[:id])
    @trail = current_user.trails.find_by(id: params[:id])
    @trail.delete
 if @trail && @trail.delete
    redirect '/trails'

  else
    redirect "/trails/#{params[:id]}"
  end
end
end









end #of class
