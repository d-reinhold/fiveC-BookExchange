class ListingsController < ApplicationController
  before_filter :authenticate_user, :only => [ :create, :edit, :update, :destroy] 
  before_filter :correct_user, :only => [ :edit, :update, :destroy]
  
  
  def show
    @listing = Listing.find(params[:id])
    @title = @listing.title
    @transaction = @listing.transaction
  end

  def create
    puts params
    @user = current_user
    @listing = @user.listings.new(params[:listing])
    if @listing.save
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
    puts "init delete"
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
      gen_course_search_array(params[:search_courses])      
    elsif session[:last_search]
      puts "didnt get search params, but had a last search"
      gen_search_arrays(session[:last_search])
    else
      @listings = Listing.order("title")
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  private
  
    def gen_keyword_search_arrays(keyword)
      puts 'searching keywords'
      @keyword = keyword.downcase
      @listings_title = Listing.where("lower(title) LIKE ?", "%#{@keyword}%").order("title")
      @listings_author = Listing.where("lower(author) LIKE ?", "%#{@keyword}%").order("title")
      @listings_isbn = Listing.where("lower(isbn) LIKE ?", "%#{@keyword}%").order("title")
      session[:last_search] = @keyword
    end
    
    def gen_course_search_array(course)
      puts 'searching courses'
      @course = course.downcase
      @matching_courses = Course.where("lower(name) LIKE ?", "%#{@course}%").order("name")
      session[:last_search] = @course
      puts "done searching courses"
    end
    


    def correct_user
      @listing = Listing.find(params[:id])
      unless params[:listing].nil?
        redirect_to '/', :notice => "You don't have permission to access that page!" unless signed_in? and @listing.user.id == current_user.id   
      end
    end  



end
