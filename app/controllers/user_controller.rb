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
    @user = User.new(username: (params[:username]), email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to "user/#{@user.slug}"
    else
      flash[:message] = @user.errors.full_messages.join(', ')
      erb :signup
    end
  end

  get "/signup" do
    if logged_in?
      redirect to "user/#{current_user.slug}"
    else
      @user = User.new
      erb :signup
    end
  end

end
