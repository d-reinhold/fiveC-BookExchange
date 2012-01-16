class ListingsController < ApplicationController
  before_filter :authenticate_user, :only => [ :create, :edit, :update, :destroy] 
  before_filter :correct_user, :only => [ :edit, :update, :destroy]
  
  def new
    @book = Book.find(params[:book_id])
    if signed_in?
      @user = @current_user
      @listing = @current_user.listings.new
    else
      @user = User.new
      @listing = @user.listings.new
    end
  end  
  
  def show
    unless Listing.exists?(:id => params[:id])
      flash[:error] = 'That listing does not exist.'
      redirect_to root_path
    else
      @listing = Listing.find(params[:id])
      @title = @listing.book.title
      @transaction = @listing.transaction
      session[:returning_to_search] = true
    end
  end

  def create
    puts 'creating listing!'
    puts params
    @user = current_user
    @listing = @user.listings.new(params[:listing])
    puts @listing.book.title
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
    puts params[:page]
    session[:from_search] = true
    if params[:search_books] == '' and params[:search_courses] == ''
      puts 'search params blank'
      @listings = Listing.page(params[:page]).per(20)
      session[:last_search] = nil
    elsif params[:search_books].present?
      puts "got book params: #{params[:search_books]}"
      gen_book_search_array(params)
    elsif params[:search_courses].present?
      puts "got course params: #{params[:search_courses]}"
      gen_course_search_array(params)      
    elsif session[:last_search]
      puts "didnt get search params, but had a last search"
      puts "LAST SEARCH: #{session[:last_search]}"
      puts "PAGE NUM1: #{params[:page]}"
      if session[:last_search_type] == 'book'
        gen_book_search_array(session[:last_search], session[:last_search][:page])
      else 
        gen_course_search_array(session[:last_search], session[:last_search][:page])
      end
    else
      @listings = Listing.page(params[:page]).per(20)
    end
    session[:returning_to_search] = false
    respond_to do |format|
      format.js {session[:remote_pag] = true}
      format.html {session[:remote_pag] = false}
    end
  end
  
  private
  
  def gen_book_search_array(parameters, page_num='')
    puts 'searching books'
    @query = parameters[:search_books]
    @matching_books = Book.where('title ILIKE ? OR author ILIKE ? OR isbn = ?', "%#{@query}%", "%#{@query}%", "%#{@query}%").order('title').order('author').page(params[:page]).per(10)

    
    #@listings_title = Listing.where("title ILIKE ?", "%#{@keyword}%").order("title")
    #@listings_author = Listing.where("author ILIKE ?", "%#{@keyword}%").order("title")
    #@listings_isbn = Listing.where("isbn ILIKE ?", "%#{@keyword}%").order("title")
    #@listings_title = Listing.search_by_title(@keyword).order('title').order('author').order('price_dollars').order('price_cents')
    #@listings_author = Listing.search_by_author(@keyword).order('author').order('title').order('price_dollars').order('price_cents')
    #@listings_isbn = Listing.search_by_isbn(@keyword).order('isbn').order('price_dollars').order('price_cents')
    session[:last_search] = parameters
    session[:last_search_type] = 'book'
  end
  
  def gen_course_search_array(parameters, page_num='')
    puts 'searching courses'
    puts parameters
    @query = parameters[:search_courses]
    #@matching_courses = Course.where("lower(name) LIKE ? OR lower(number) LIKE ? OR lower(department) LIKE ?", "%#{@course}%","%#{@course}%","%#{@course}%").order("number")
    if parameters[:school]
      @keywords = '%'+@query.gsub(' ', '% %')+'%'
      puts @keywords
      #@matching_courses = Course.search_by_course_keywords(@course).where('school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ?', params[:school][0],params[:school][1],params[:school][2],params[:school][3],params[:school][4],params[:school][5]).order('number').order('section').page(params[:page]).per(5)
      #@matching_courses = Course.search_by_name_or_prof_or_department_or_number(params[:search_courses],params[:search_courses],params[:search_courses],params[:search_courses]).where('school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ?', params[:school][0],params[:school][1],params[:school][2],params[:school][3],params[:school][4],params[:school][5]).order('number').order('section').page(params[:page]).per(5)
      if session[:returning_to_search] == true
        puts "PAGE NUM2: #{page_num}"
        @matching_courses = Course.where('name ILIKE ? OR prof ILIKE ? OR department ILIKE ? OR number = ?',@keywords,@keywords,@keywords,@keywords).where('school = ? OR school = ? OR school = ? OR school = ? OR school = ? OR school = ?', parameters[:school][0],parameters[:school][1],parameters[:school][2],parameters[:school][3],parameters[:school][4],parameters[:school][5]).order('number').order('section').page(page_num).per(5)
      else
        @matching_courses = Course.where('name ILIKE ? OR prof ILIKE ? OR department ILIKE ? OR number = ?',@keywords,@keywords,@keywords,@keywords).where('school = ? OR school = ? OR school = ? OR school = ? OR school = ? OR school = ?', parameters[:school][0],parameters[:school][1],parameters[:school][2],parameters[:school][3],parameters[:school][4],parameters[:school][5]).order('number').order('section').page(params[:page]).per(5)
      end
    else
      @matching_courses = Array.new
    end
    session[:last_search] = parameters
    session[:last_search_type] = 'course'
  end
    


    def correct_user
      @listing = Listing.find(params[:id])
      unless params[:listing].nil?
        redirect_to '/', :notice => "You don't have permission to access that page!" unless signed_in? and @listing.user.id == current_user.id   
      end
    end  



end
