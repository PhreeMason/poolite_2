require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    @restrooms = Restroom.all
    @logged = logged_in?
    erb :index
  end

  get "/signup" do
    if logged_in?
      redirect to "user/#{current_user.id}"
    else
      erb :signup
    end
  end

  post "/signup" do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @user.id
    redirect to "user/#{@user.id}"
  end

  get "/login" do
    if logged_in?
      redirect to "user/#{current_user.id}"
    else
      erb :login
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      @user = user
      redirect "user/#{@user.id}"
    else
      redirect "/login"
    end
  end


  get "/logout" do
    session.clear
    redirect "/login"
  end

  helpers do
    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    def my_review?(review)
      current_user.reviews.include?(review)
    end

  end

end
