class SessionsController < ApplicationController

  def create
    puts "trying to sign you in"
    auth = request.env["omniauth.auth"]
    @user = User.find_by_uid(auth["uid"])
    puts '--------------- Initiating new user session ---------------'
    if @user.nil?
      puts 'You are signing up.'
      @greeting = "Welcome to Campus Bookswap"
      @user = User.create_with_omniauth(auth)
    else
      puts 'You are signing in.'
      @greeting = "Welcome back"
    end
    @user.update_with_omniauth(auth)
    @name = @user.name.split(' ')[0]
    session[:user_id] = @user.id
    if session[:fb_store_listing_params].present?
      puts 'You are logging in to list a book for sale.'
      @listing = @user.listings.create(session[:fb_store_listing_params]['listing'])
      session[:fb_store_listing_params] = nil
      @url = @user
      if @listing.save
        @tag = "Your listing was posted!"
      else
        @tag = "Unfortunately your listing could not be created! Please try again!"
      end
    elsif session[:fb_store_request_url].present?
      puts 'You are logging in to request a book.'
      @url = session[:fb_store_request_url]
      session[:fb_store_request_url] = nil
    elsif session[:fb_store_listing_url].present?
      puts 'You are logging in to buy a book.'
      @url = session[:fb_store_listing_url]
    else
      puts 'You are logging in with the default button.'
      @url = @user
    end
    redirect_to @url, :notice => "#{@greeting}, #{@name}! #{@tag}"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
