require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end
  use Rack::Flash

  get "/" do
    @restrooms = Restroom.all
    erb :index
  end


  helpers do
    def current_user
      if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end

    def logged_in?
      !!current_user
    end

    def case_space(string)
      string.gsub(/\s+/, "").downcase
    end
    
  end

end
