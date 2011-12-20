class PagesController < ApplicationController
  def home
    @title = 'Home'
    if signed_in?
      @user = @current_user
      @listing = @current_user.listings.new
    else
      @user = User.new
      @user.listings.new
    end
    
  end

  def about
    @title = 'About'
  end

end
