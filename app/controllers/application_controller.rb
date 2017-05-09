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

    def review_fail
      flash[:message] = "Please make sure to choose a location or add a new one and also a star rating"
      redirect to '/review/new'
    end
    def stars_bod?
      !params[:review][:stars].blank? && !params[:review][:body].blank?
    end
    def one_resaturant?
      if params[:review][:restroom_hash].values.none? {|a| a.empty?}
        return true if params[:review][:old_restroom].empty?
      elsif !params[:review][:old_restroom].empty?
        return true if !params[:review][:restroom_hash].values.none? {|a| a.empty?}
      else
        false
      end
    end
    def all_good?
      stars_bod? && one_resaturant?
    end

  end

end
