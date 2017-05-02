class UserController < ApplicationController

  get '/user/:slug' do
    if logged_in?
      @user = current_user
      @profile= User.findby_slug(params[:slug])
      if @profile.id == @user.id
        @logged = logged_in?
        erb :'/user/profile'
      else
        erb :'user/show_user'
      end
    else
      @profile= User.findby_slug(params[:slug])
      @logged = logged_in?
      erb :'user/show_user'
    end
  end

end
