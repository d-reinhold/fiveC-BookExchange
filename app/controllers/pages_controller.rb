class PagesController < ApplicationController
  def home
    @title = 'Home'
    if signed_in?
      @user = @current_user
      @listing = @current_user.listings.new
    else
      @user = User.new
      @user.listings.new
      flash.now[:success] ="Welcome to the 5C Book Exchange, the new one-stop service for all your textbook needs! Just search below for textbooks, or for your upcoming classes, and we'll tell you what books you need for those classes, and if any 5C students are trying to sell those books. All in one place! See the 'About' page for more information. Since we're a brand new service, the book you looking for may not be for sale yet; check back soon because we're still growing! Please feel free to list any books you want to sell; you will recieve an email when someone wants to buy one."
    end
    
  end

  def about
    @title = 'About'
  end

end
