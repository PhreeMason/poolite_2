class UserController < ApplicationController

  get '/user/:id' do
    if logged_in?
      @user= User.find(params[:id])
      if @user.id == current_user.id
        @logged = logged_in?
        erb :'/user/profile'
      else
        erb :'user/show_user'
      end
    else
      redirect to '/login'
    end
  end

end
