class TrailsController < ApplicationController


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
      @trail = Trail.create(name: params[:name], location: params[:location], date: params[:date], notes: params[:notes], distance: params[:distance], user_id: session[:id] )
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

          erb :'/trails/edit'

        else
          redirect to '/login'
        end
      end

    patch '/trails/:id' do

         if logged_in? && params[:name] == "" || params[:location] == ""
           redirect to "/trails/#{params[:id]}/edit"
         else
           @trail = Trail.find_by_id(params[:id])
           @trail.update(name: params[:name], location: params[:location], date: params[:date], notes: params[:notes], distance: params[:distance])
           @trail.save

           redirect to "trails/#{@trail.id}"
         end
       end
   #delete

   delete '/trails/:id' do
      @trail = Trail.find_by_id(params[:id])
      @user = current_user
      if logged_in?
        @trail.delete

        redirect to '/trails'
      else
        redirect "/trails/#{@trail.id}"
      end
    end
end
