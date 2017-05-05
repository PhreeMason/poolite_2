class RestroomController < ApplicationController

  get '/restrooms' do
    @restrooms = Restroom.all
    erb :'/restroom/index'
  end

  get '/restrooms/:id' do
    @restroom = Restroom.find(params[:id])
    erb :'/restroom/show_restroom'
  end

end
