class ListingsController < ApplicationController
  before_filter :authenticate_user, :only => [ :create, :edit, :update, :destroy] 
  before_filter :correct_user, :only => [ :edit, :update, :destroy]
  
  
  def show
    unless Listing.exists?(:id => params[:id])
      flash[:error] = 'That listing does not exist.'
      redirect_to root_path
    else
      @listing = Listing.find(params[:id])
      @title = @listing.title
      @transaction = @listing.transaction
    end
  end

  def create
    puts 'creating listing!'
    @user = current_user
    @listing = @user.listings.new(params[:listing])
    @book = Book.where("lower(title) LIKE ?", "%#{@listing.title.downcase}%").limit(1).all
    unless @book.empty?
      puts 'Found a course that requires this book!'
      @listing.book_id = @book.first.id
    end
    if @listing.save
      #ListingMailer.listed_book(@listing).deliver
      flash[:success] = 'Your listing was created!'
      redirect_to @user
    else
      flash[:error] = 'Your listing was not created'
      redirect_to root_path
    end
  end

  def edit
    @listing = Listing.find(params[:id])
    if @listing.transaction.status != "available"
      flash[:error] = 'That listing can not be edited at this time.'
      redirect_to root_path
    end
  end

  def update
    puts "Start Listing Update!"
    puts params
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(params[:listing])
      flash[:success] = 'Listing updated!'
      if signed_in?
        redirect_to @current_user
      else
        redirect_to '/'
      end
    else
      flash[:error] = @listing.errors.full_messages
      redirect_to edit_listing_path(@listing)
    end
  end

  def destroy
    puts "about to destroy a listing"
    Listing.find(params[:id]).destroy
    flash[:success] = 'Listing deleted!'
    redirect_to @current_user
    
  end

  def index
    puts params
    session[:from_search] = true
    if params[:search_keywords] == '' and params[:search_courses] == ''
      puts 'search params blank'
      @listings = Listing.order("title")
      session[:last_search] = nil
    elsif params[:search_keywords].present?
      puts "got keyword params: #{params[:search_keywords]}"
      gen_keyword_search_arrays(params[:search_keywords])
    elsif params[:search_courses].present?
      puts "got course params: #{params[:search_courses]}"
      gen_course_search_array(params)      
    elsif session[:last_search]
      puts "didnt get search params, but had a last search"
      if session[:last_search_type] == 'keyword'
        gen_keyword_search_arrays(session[:last_search])
      else 
        gen_course_search_array(session[:last_search])
      end
    else
      @listings = Listing.order("title")
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  private
    
  
  def gen_keyword_search_arrays(listing_params)
    puts 'searching listings'
    @keyword = listing_params
    #@listings_title = Listing.where("lower(title) LIKE ?", "%#{@keyword}%").order("title")
    #@listings_author = Listing.where("lower(author) LIKE ?", "%#{@keyword}%").order("title")
    #@listings_isbn = Listing.where("lower(isbn) LIKE ?", "%#{@keyword}%").order("title")
    @listings_title = Listing.search_by_title(listing_params)
    @listings_author = Listing.search_by_author(listing_params)
    @listings_isbn = Listing.search_by_isbn(listing_params)
    session[:last_search] = listing_params
    session[:last_search_type] = 'keyword'
  end
  
  def gen_course_search_array(params)
    puts 'searching courses'
    puts params
    #@matching_courses = Course.where("lower(name) LIKE ? OR lower(number) LIKE ? OR lower(department) LIKE ?", "%#{@course}%","%#{@course}%","%#{@course}%").order("number")
    @matching_courses = Course.search_by_name_or_prof_or_department_or_number(params[:search_courses],params[:search_courses],params[:search_courses],params[:search_courses]).where('school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ?', params[:school][0],params[:school][1],params[:school][2],params[:school][3],params[:school][4],params[:school][5]).order('number')
    session[:last_search] = params[:search_courses]
    session[:last_search_type] = 'course'
    puts "done searching courses"
  end
    


    def correct_user
      @listing = Listing.find(params[:id])
      unless params[:listing].nil?
        redirect_to '/', :notice => "You don't have permission to access that page!" unless signed_in? and @listing.user.id == current_user.id   
      end
    end  



end
