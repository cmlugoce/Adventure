class TrailsController < ApplicationController


get '/trails' do
  if logged_in?
    @trails = Trail.all
    erb :'/trails/index'

  else
    redirect '/login'

  end
end




 get 'trails/new' do
   if logged_in?

     erb :'/trails/new'

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

 get '/trails/:id/edit' do
   @trail = Trail.find_by_id(params[:id])

   if logged_in? && @trail.user == current_user
     erb :'/trails/edit'

   else
     redirect '/login'
   end
 end

 patch '/trails/:id' do
   if logged_in?

     @trail = Trail.find_by_id(params[:id])
     if !@trail.name.empty? && !@trail.location.empty? && !@trail.date.empty?
     @trail.update(name: params[:name], location: params[:location], date: params[:date], notes: params[:notes], distance: params[:distance])
     @trail.save
   redirect "/trails/#{@trail.id}"
 else
   redirect "/trails/#{@trail.id}/edit"
 end
else
  redirect '/login'
end
end


delete '/trails/:id/delete' do

    @trail = Trail.find_by_id(params[:id])
    if @trail && current_user.id
      @trail.delete

    redirect '/trails'



     else
    redirect "/trails/#{@trail.id}"
    end
  end




end

end #of class
