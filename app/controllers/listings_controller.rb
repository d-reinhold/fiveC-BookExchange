class ListingsController < ApplicationController
  before_filter :authenticate_user, :only => [:new, :create, :edit, :update] 
  before_filter :correct_user, :only => [ :edit, :update]
  
  
  def show
    @listing = Listing.find(params[:id])
    @title = @listing.title
  end

  def new
  end

  def create
    @user = @current_user
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
  end

  def update
  end

  def destroy
  end

  def index
    puts "hit index" 
    if params[:search] == ''
      puts 'search params blank'
      @listings = Listing.all
      session[:last_search] = nil
    elsif params[:search].present?
      puts "got search params: #{params[:search]}"
      gen_search_arrays(params[:search])         
    elsif session[:last_search]
      puts "didnt get search params, but had a last search"
      gen_search_arrays(session[:last_search])
    else
      @listings = Listing.all
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  private
  
    def gen_search_arrays(keyword)
      @keyword = keyword
      @listings_title = Listing.where("title LIKE ?", "%#{@keyword}%")
      @listings_author = Listing.where("author LIKE ?", "%#{@keyword}%")
      @listings_isbn = Listing.where("isbn LIKE ?", "%#{@keyword}%")
      session[:last_search] = @keyword
      puts "Last Search: #{session[:last_search]}"
    end
    
    def authenticate_user
      deny_access unless signed_in?
    end

    def correct_user
      @listing = Listing.find(params[:id])
      redirect_to '/', :notice => "You don't have permission to access that page!" unless @listing.user.id == current_user.id
    end  

    def deny_access
      redirect_to '/', :notice => "Please sign in to access this page."
    end
  
  

end
