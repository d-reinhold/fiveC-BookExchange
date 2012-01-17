class PagesController < ApplicationController
  def home
    @title = 'Home'
    if signed_in?
      @user = @current_user
      @listing = @current_user.listings.new
    else
      @user = User.new
      @user.listings.new
      unless params[:autofill_title]
        flash.now[:success] ="Welcome to the 5C Book Exchange! Just search below for your upcoming classes, and we'll tell you what books you need for those classes, and if any 5C students are trying to sell those books. All in one place! You can also search directly for a book if you know the title, author, or ISBN. See the 'About' page for more information. Since we're a brand new service, the book you're looking for may not be for sale yet; check back soon because we're still growing! Please feel free to list any books you want to sell; you will recieve an email when someone wants to buy one of your books!"
      end
    end
    
    @autofill_title = params[:autofill_title]
    @autofill_author = params[:autofill_author]
    @autofill_isbn = params[:autofill_isbn]
    @autofill_edition = params[:autofill_edition]
    puts @autofill_isbn
    puts @autofill_edition
  end

  def about
    @title = 'About'
  end

end
