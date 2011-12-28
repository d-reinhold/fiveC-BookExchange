class ListingsController < ApplicationController
  before_filter :authenticate_user, :only => [ :create, :edit, :update] 
  before_filter :correct_user, :only => [ :edit, :update]
  
  
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
  end

  def index
    puts params
    session[:from_search] = true
    if params[:search] == ''
      puts 'search params blank'
      @listings = Listing.order("title")
      session[:last_search] = nil
    elsif params[:search].present?
      puts "got search params: #{params[:search]}"
      gen_search_arrays(params[:search])         
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
  
    def gen_search_arrays(keyword)
      @keyword = keyword.downcase
      @listings_title = Listing.where("lower(title) LIKE ?", "%#{@keyword}%").order("title")
      @listings_author = Listing.where("lower(author) LIKE ?", "%#{@keyword}%").order("title")
      @listings_isbn = Listing.where("lower(isbn) LIKE ?", "%#{@keyword}%").order("title")
      session[:last_search] = @keyword
      puts "Last Search: #{session[:last_search]}"
    end
    


    def correct_user
      @listing = Listing.find(params[:id])
      unless params[:listing].nil?
        redirect_to '/', :notice => "You don't have permission to access that page!" unless signed_in? and @listing.user.id == current_user.id   
      end
    end  



end
