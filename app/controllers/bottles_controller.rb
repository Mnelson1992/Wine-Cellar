class BottlesController < ApplicationController

  get '/bottles' do
    if logged_in?
      @bottles = Bottle.all
      erb :'bottles/show_bottle'
    else
      redirect to '/login'
    end
  end




end
