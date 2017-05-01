class RestroomController < ApplicationController

  get '/restrooms' do
    @restrooms = Restroom.all
    @logged = logged_in?
    erb :'/restroom/index'
  end

  get '/restrooms/:id' do
    @restroom = Restroom.find(params[:id])
    @logged = logged_in?
    erb :'/restroom/show_restroom'
  end

end
