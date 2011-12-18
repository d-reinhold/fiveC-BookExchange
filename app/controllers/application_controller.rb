class ApplicationController < ActionController::Base
  protect_from_forgery
  private
  
  def session_name
    User.find(session[:user_id])
  end
  helper_method :session_name
  
  def current_user
    @current_user = User.find(session[:user_id])# unless session[:user_id].nil?
  end
  helper_method :current_user
  
  def signed_in?
    current_user.nil?
  end
  helper_method :signed_in?
  
end
