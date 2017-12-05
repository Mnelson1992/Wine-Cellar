class BottlesController < ApplicationController

  get '/bottles' do
    if logged_in?
      @bottle = Bottle.all
      erb :'bottles/show_bottle'
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
      @bottle = Bottle.new(name: params[:name], type: params[:tpye], year: params[:year], location: [:location])
      @bottle.user_id=session[:user_id]
      @bottle.save
    else
      redirect to '/bottles/new'
    end
  end




end
