class RequestsController < ApplicationController
  before_filter :authenticate_user, :only => [ :destroy]   
  
  def new
    puts "Title: " + params[:autofill_title]
    @book = Book.where('title = ?', params[:autofill_title]).first
    @request = Request.new
    session[:returning_to_search] = true
  end

  def create
    @book = Book.find(params[:request][:book_id])
    if not signed_in?
      session[:fb_store_request_url] = "/requests/new?autofill_title=#{@book.title}&autofill_author=#{@book.author}&autofill_isbn=#{@book.isbn}&autofill_edition=#{@book.edition}"
      redirect_to '/auth/facebook/'
    else
      @request = current_user.requests.new(params[:request])
      @request.status = 'unavailable'
      @listings = Listing.where('book_id = ?', @request.book_id)
      unless @listings.empty?
        @listings.each do |l|
          if l.transaction.status == 'available'
            @request.status = 'available'
          end
        end
      end
      if @request.save
        flash[:success] = 'Your request has been created!'
        redirect_to current_user
      else
        flash[:error] = @request.errors.full_messages
        redirect_to root_path
      end
    end
  end

  def destroy
    puts 'about to delete a request'
    @request = Request.find(params[:id])
    if @request.user.id == @current_user.id
      @request.destroy
    else
      flash[:error] = "You don't have permission to do that!"
      redirect_to root_url
    end
  end

end
