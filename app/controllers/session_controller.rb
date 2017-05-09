class SessionController < ApplicationController
  get "/signup" do
    if logged_in?
      redirect to "user/#{current_user.slug}"
    else
      erb :signup
    end
  end

  get "/login" do
    if logged_in?
      redirect to "user/#{current_user.slug}"
    else
      erb :login
    end
  end

  post "/login" do
    user = User.find_by(:username => (params[:username]))
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "user/#{user.slug}"
    else
      flash[:message] = "Hmmm something went wrong lets try that again."
      redirect "/login"
    end
  end


  get "/logout" do
    session.clear
    redirect "/login"
  end


end
