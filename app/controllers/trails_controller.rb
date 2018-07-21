require 'rack-flash'

class TrailsController < ApplicationController

  use Rack::Flash
#create

get '/trails' do
    if logged_in?
      @user = current_user
      session[:user_id] = @user.id
      @trails = Trail.all
      erb :'/trails/index'

    else
      redirect to '/login'
    end
  end

  get '/trails/new' do
    if logged_in?
      erb :'/trails/new'
    else
      redirect to '/login'
    end
  end


  post '/trails' do
    if params[:name] == "" || params[:location] == ""
      redirect to '/trails/new'

    else
      @trail = Trail.create(name: params[:name], location: params[:location], date: params[:date], notes: params[:notes], distance: params[:distance], user_id: session[:user_id] )
      @trail.save
      redirect to "/trails/#{@trail.id}"
    end
  end


  #read





  get '/trails/:id' do
    if logged_in?
      @user = current_user
      @trail = Trail.find_by_id(params[:id])
         erb :'/trails/show'

       else
         redirect '/login'
       end
   end

   #update

   get '/trails/:id/edit' do
     if logged_in?
       @trail = Trail.find_by_id(params[:id])
       if @trail.user == current_user

          erb :'/trails/edit'
        else
         flash[:message] = "You are not authorized to edit or delete this entry"
          redirect to "/trails/#{params[:id]}"


        end
        end
      end

    patch '/trails/:id' do

         if logged_in? && params[:name] == "" || params[:location] == ""
            redirect to "/trails/#{params[:id]}/edit"
         else
           @trail = Trail.find_by_id(params[:id])
           @trail.update(name: params[:name], location: params[:location], date: params[:date], notes: params[:notes], distance: params[:distance])
           @trail.save
          redirect "/trails/#{params[:id]}"
         end
       end
   #delete

   delete '/trails/:id/delete' do
      @trail = Trail.find_by_id(params[:id])
     if logged_in?
       @user = current_user
       if @user.trails.include?(@trail)
        @trail.delete
        redirect to '/trails'
      else
        flash[:message] = "You are not authorized to delete this entry"
        redirect "/trails/#{params[:id]}"
      end
      end
    end
end
