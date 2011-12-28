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
  
  
  def from_search?
    session[:from_search] == true
  end
  helper_method :from_search?
  
  
  
  
  def authenticate_user
    deny_access unless signed_in?
  end  
  
  def deny_access
    redirect_to '/', :notice => "Please sign in to access that page."
  end  
  
  def current_user?(user)
    user == current_user
  end
  
end
