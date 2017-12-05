class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/bottles'
    end
  end

  post '/signup' do
    if params[:email] == "" || params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(email: params[:email], username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/bottles'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/bottles'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/bottles'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

end
