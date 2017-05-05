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
      erb :index
    else
      @restrooms = Restroom.all
      erb :index
    end
  end


  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    def my_review?(review)
      current_user.reviews.include?(review)
    end

    def case_space(string)
      string.gsub(/\s+/, "").downcase
    end

  end

end
