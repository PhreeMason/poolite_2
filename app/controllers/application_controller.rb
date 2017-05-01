require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end
  use Rack::Flash

  get "/" do
    if logged_in?
      @restrooms = Restroom.all
      @logged = logged_in?
      @user = current_user
      erb :index
    else
      @restrooms = Restroom.all
      erb :index
    end
  end

  get "/signup" do
    if logged_in?
      redirect to "user/#{current_user.slug}"
    else
      erb :signup
    end
  end

  post "/signup" do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @user.id
    redirect to "user/#{@user.slug}"
  end

  get "/login" do
    if logged_in?
      redirect to "user/#{current_user.slug}"
    else
      erb :login
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      @user = user
      redirect "user/#{@user.slug}"
    else
      flash[:message] = "Hmmm something went wrong lets try that again."
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
