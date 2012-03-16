class RequestsController < ApplicationController
  def new
    puts "Title: " + params[:autofill_title]
    @book = Book.where('title = ?', params[:autofill_title]).first
    @request = Request.new
    session[:returning_to_search] = true
  end

  def create
    puts 'creating request!'
    puts params
    @request = Request.new(params[:request])
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
      #ListingMailer.listed_book(@listing).deliver
      flash[:success] = 'Your request has been created!'
      redirect_to current_user ? current_user : root_path
    else
      flash[:error] = @request.errors.full_messages
      redirect_to root_path
    end
  end

  def destroy
    puts 'about to delete a request'
    @request = Request.find(params[:id])
    if @request.student_email == @current_user.email
      @request.destroy
    else
      flash[:error] = "You don't have permission to do that!"
      redirect_to root_url
    end
  end

end
