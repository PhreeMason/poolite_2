class UserController < ApplicationController

  get '/user/:slug' do
    if logged_in?
      @profile= User.findby_slug(params[:slug])
      if @profile.id == current_user.id
        erb :'/user/profile'
      else
        erb :'user/show_user'
      end
    else
      @profile= User.findby_slug(params[:slug])
      erb :'user/show_user'
    end
  end

  post "/signup" do
    @user = User.create(username: (params[:username]), email: params[:email], password: params[:password])
    session[:user_id] = @user.id
    redirect to "user/#{@user.slug}"
  end

end
