class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user, except: %i[index show]
  helper_method %i[current_user logged_in? logout]
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def log_in(user)
    session[:user_id] = user.id
    flash[:info] = "You are now logged in"
  end

  def logout
    session.delete(:user_id)
    flash[:message] = "Thanks for usign Tweetable"
  end

  def authenticate_user
    return if logged_in?

    flash[:message] = "You need to be logged in to perform this action"
    redirect_to login_path
  end
end
