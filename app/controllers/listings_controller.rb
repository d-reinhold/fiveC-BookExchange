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
    @listing.book_id = match_listing_to_book(@listing)
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
      @listing.book_id = match_listing_to_book(@listing)
      @listing.save
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
      @listings = Listing.order("title").page(params[:page]).per(20)
      session[:last_search] = nil
    elsif params[:search_keywords].present?
      puts "got keyword params: #{params[:search_keywords]}"
      gen_keyword_search_arrays(params)
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
      @listings = Listing.order("title").page(params[:page]).per(20)
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  private
    
  def match_listing_to_book(listing)
    if listing.isbn != ''
      book = Book.where("isbn = ?", listing.isbn.gsub('-','')).limit(1).all
    end
    if book.nil? or book.empty?
      puts 'no isbn on listing, or isbn doesnt match'
      downcase_title = listing.title.downcase
      downcase_title_nosymbol = downcase_title.gsub('&', 'and')
      downcase_author = '%'+listing.author.downcase.split(' ').last
      book = Book.where("(lower(title) = ? or lower(title) = ?) and lower(author) LIKE ?", downcase_title, downcase_title_nosymbol, downcase_author).limit(1).all
    end
    unless book.empty?
      puts 'Found a course that requires this book!'
      return book.first.id 
    else
      puts 'no Books match this listing'
      return -1
    end
  end
  
  def gen_keyword_search_arrays(params)
    puts 'searching listings'
    @keyword = params[:search_keywords]
    @listings_title = Listing.where("title ILIKE ?", "%#{@keyword}%").order("title")
    @listings_author = Listing.where("author ILIKE ?", "%#{@keyword}%").order("title")
    @listings_isbn = Listing.where("isbn ILIKE ?", "%#{@keyword}%").order("title")
    #@listings_title = Listing.search_by_title(@keyword).order('title').order('author').order('price_dollars').order('price_cents')
    #@listings_author = Listing.search_by_author(@keyword).order('author').order('title').order('price_dollars').order('price_cents')
    #@listings_isbn = Listing.search_by_isbn(@keyword).order('isbn').order('price_dollars').order('price_cents')
    session[:last_search] = params
    session[:last_search_type] = 'keyword'
  end
  
  def gen_course_search_array(params)
    puts 'searching courses'
    puts params
    @course = params[:search_courses]
    #@matching_courses = Course.where("lower(name) LIKE ? OR lower(number) LIKE ? OR lower(department) LIKE ?", "%#{@course}%","%#{@course}%","%#{@course}%").order("number")
    if params[:school]
      @keywords = '%'+@course.gsub(' ', '% %')+'%'
      puts @keywords
      #@matching_courses = Course.search_by_course_keywords(@course).where('school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ?', params[:school][0],params[:school][1],params[:school][2],params[:school][3],params[:school][4],params[:school][5]).order('number').order('section').page(params[:page]).per(5)
      #@matching_courses = Course.search_by_name_or_prof_or_department_or_number(params[:search_courses],params[:search_courses],params[:search_courses],params[:search_courses]).where('school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ?', params[:school][0],params[:school][1],params[:school][2],params[:school][3],params[:school][4],params[:school][5]).order('number').order('section').page(params[:page]).per(5)
      @matching_courses = Course.where('name ILIKE ? OR prof ILIKE ? OR department ILIKE ? OR number = ?',@keywords,@keywords,@keywords,@keywords).where('school = ? OR school = ? OR school = ? OR school = ? OR school = ? OR school = ?', params[:school][0],params[:school][1],params[:school][2],params[:school][3],params[:school][4],params[:school][5]).order('number').order('section').page(params[:page]).per(5)
    else
      @matching_courses = Array.new
    end
    session[:last_search] = params
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
