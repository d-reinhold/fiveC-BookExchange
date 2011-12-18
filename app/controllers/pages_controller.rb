class PagesController < ApplicationController
  def home
    @title = 'Home'
    @listing = Listing.new
  end

  def about
    @title = 'About'
  end

end
