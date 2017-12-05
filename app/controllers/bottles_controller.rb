class BottlesController < ApplicationController

  get '/bottles' do
    if logged_in?
      @bottle = Bottle.all
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
    if params[:name] != ""
      @bottle = Bottle.new(name: params[:name], type: params[:type], year: params[:year], location: params[:location])
      @bottle.user_id=session[:user_id]
      @bottle.save
    else
      redirect to '/bottles/new'
    end
  end

  get '/bottles/:id' do
    if logged_in?
      @bottle = Bottle.find_by_id(params[:id])
      erb :'bottles/show_bottle'
    else
      redirect to '/login'
    end
  end




end
