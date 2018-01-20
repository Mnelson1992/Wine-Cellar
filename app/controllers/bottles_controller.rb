class BottlesController < ApplicationController

  get '/home' do
    if logged_in?
      erb :'bottles/home'
    else
      redirect to '/login'
    end
  end
  
  get '/bottles' do
    if logged_in?
      erb :'bottles/bottles'
    else
      redirect to '/login'
    end
  end

  get '/bottles/new' do
    if logged_in?
      erb :'/bottles/create_bottle'
    else
      redirect to '/login'
    end
  end

  post '/bottles' do
    if params[:name] == ""
      redirect to '/bottles/new'
    else
      @bottle = current_user.bottles.create(name: params[:name], grape: params[:grape], year: params[:year], location: params[:location])
      redirect to '/bottles'
    end
  end

  get '/bottles/:id' do
    authenticate_user!
    if @bottle = current_user.bottles.find_by_id(params[:id])
      erb :'bottles/show_bottle'
    else
      redirect to '/bottles'
    end
  end

  get '/bottles/:id/edit' do
    authenticate_user!
    if @bottle = current_user.bottles.find_by_id(params[:id])
      erb :'bottles/edit_bottle'
    else
      redirect to '/bottles'
    end
  end

  patch '/bottles/:id' do
    authenticate_user!
    if @bottle = current_user.bottles.find_by_id(params[:id])
      if @bottle.update(params[:bottle])
        redirect to "/bottles/#{@bottle.id}"
      else
        erb :'bottles/edit_bottle', locals: { message: @bottle.errors.full_messages.to_sentence }
      end
    else
      redirect to '/bottles'
    end
  end

  delete '/bottles/:id/delete' do
    if logged_in?
      @bottle = Bottle.find_by_id(params[:id])
      if @bottle.user_id == current_user.id
        @bottle.delete
        redirect to '/bottles'
      else
        redirect to '/bottles'
      end
    else
      redirect to '/bottles'
    end
  end

end
