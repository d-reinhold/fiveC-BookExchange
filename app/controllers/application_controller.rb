class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  private
  
  def current_user
    if User.all.empty?
      session[:user_id] = nil
      @current_user = nil
    else
      @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
    end
  end
  helper_method :current_user
  
  def signed_in?
    current_user
    !@current_user.nil?
  end
  helper_method :signed_in?
  
end
