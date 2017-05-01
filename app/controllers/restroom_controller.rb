class RestroomController < ApplicationController

  get '/restrooms' do
    @user = current_user
    @restrooms = Restroom.all
    @logged = logged_in?
    erb :'/restroom/index'
  end

  get '/restrooms/:id' do
    @user = current_user
    @restroom = Restroom.find(params[:id])
    @logged = logged_in?
    erb :'/restroom/show_restroom'
  end

end
