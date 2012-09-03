class ListingsController < ApplicationController
  before_filter :authenticate_user, :only => [ :edit, :update, :destroy] 
  before_filter :correct_user, :only => [ :edit, :update, :destroy]
  autocomplete :book, [:title], :full => true, :extra_data => [:author, :title, :isbn], :value => :title, :display_value => :autocomplete_display
  autocomplete :course, [:prof, :name, :department, :school_name, :number, :school_symbol], :full => true, :extra_data => [:department, :name, :school_name, :number, :prof, :id, :school_symbol], :display_value => :autocomplete_display, :add_fields => :school_symbol, :order => :number
  
  def show
    unless Listing.exists?(:id => params[:id])
      flash[:error] = 'That listing does not exist.'
      redirect_to root_path
    else
      if session[:fb_store_listing_url]
        @from_facebook = true
        session[:fb_store_listing_url] = nil
      end
      @listing = Listing.find(params[:id])
      @title = @listing.title
      @transaction = @listing.transaction
      session[:returning_to_search] = true
    end
  end

  def create
    if not signed_in?
      session[:fb_store_listing_params] = params
    else
      @user = current_user
      @listing = @user.listings.new(params[:listing])
      @listing.book_id = Book.match_listing_to_book(@listing)
      @listing.school_id = @current_user.default_school_id
      if @listing.save
        if @listing.book_id != -1
          Book.compute_requests(@listing.book_id)
        end
        #ListingMailer.listed_book(@listing).deliver
        flash[:success] = 'Your listing was created!'
        render :js => "window.location = '/users/#{@user.id}'"
      else
        flash[:error] = @listing.errors.full_messages
        redirect_to root_path
      end
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
    old_book_id = @listing.book_id
    if @listing.transaction.status != "available"
        flash[:error] = 'That listing can not be edited at this time.'
        redirect_to root_path
    else
      if @listing.update_attributes(params[:listing])
        @listing.book_id = Book.match_listing_to_book(@listing)
        @listing.save
        if @listing.book_id != old_book_id
            Book.compute_requests(old_book_id)
            Book.compute_requests(@listing.book_id)
        end       
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
  end

  def destroy
    puts "about to destroy a listing"
    @listing = Listing.find(params[:id])
    if @listing.transaction.status != 'available'
      flash[:error] = 'Someone has requested this book!'
    else
      book_id = @listing.book_id
      @listing.destroy #destroy original listing
      Book.compute_requests(book_id)
      flash[:success] = 'Listing deleted!'
    end
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
        gen_course_search_array(session[:last_search], session[:last_search][:page])
      end
    else
      @listings = Listing.order("title").page(params[:page]).per(20)
    end
    session[:returning_to_search] = false
    respond_to do |format|
      format.js {session[:remote_pag] = true}
      format.html {session[:remote_pag] = false}
    end
  end
  
  private
    
  
  
  def gen_keyword_search_arrays(parameters)
    puts 'searching listings'
    @keyword = parameters[:search_keywords]
    @listings_title = Listing.where("title ILIKE ?", "%#{@keyword}%").order("title")
    @listings_author = Listing.where("author ILIKE ?", "%#{@keyword}%").order("title")
    @listings_isbn = Listing.where("isbn ILIKE ?", "%#{@keyword}%").order("title")
    #@listings_title = Listing.search_by_title(@keyword).order('title').order('author').order('price_dollars').order('price_cents')
    #@listings_author = Listing.search_by_author(@keyword).order('author').order('title').order('price_dollars').order('price_cents')
    #@listings_isbn = Listing.search_by_isbn(@keyword).order('isbn').order('price_dollars').order('price_cents')
    session[:last_search] = parameters
    session[:last_search_type] = 'keyword'
  end
  
  def gen_course_search_array(parameters, page_num='')
    puts 'searching courses'
    puts parameters
    if not parameters[:id].blank?
      puts 'autocomplete select!'
      @course = Course.where('id=?',parameters[:id]).page(page_num).per(5)
      @matching_courses = @course
    else
      @course = parameters[:search_courses]
      #@matching_courses = Course.where("lower(name) LIKE ? OR lower(number) LIKE ? OR lower(department) LIKE ?", "%#{@course}%","%#{@course}%","%#{@course}%").order("number")
      #if parameters[:school]
        @keywords = '%'+@course.gsub(' ', '% %')+'%'
        puts @keywords
        #@matching_courses = Course.search_by_course_keywords(@course).where('school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ?', params[:school][0],params[:school][1],params[:school][2],params[:school][3],params[:school][4],params[:school][5]).order('number').order('section').page(params[:page]).per(5)
        #@matching_courses = Course.search_by_name_or_prof_or_department_or_number(params[:search_courses],params[:search_courses],params[:search_courses],params[:search_courses]).where('school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ? OR school LIKE ?', params[:school][0],params[:school][1],params[:school][2],params[:school][3],params[:school][4],params[:school][5]).order('number').order('section').page(params[:page]).per(5)
        if session[:returning_to_search] == true
          puts "PAGE NUM2: #{page_num}"
          @matching_courses = Course.where('name ILIKE ? OR prof ILIKE ? OR department ILIKE ? OR number ILIKE ?',@keywords,@keywords,@keywords,@keywords).order('number').order('section').page(page_num).per(5)
        else
          @matching_courses = Course.where('name ILIKE ? OR prof ILIKE ? OR department ILIKE ? OR number ILIKE ?',@keywords,@keywords,@keywords,@keywords).order('number').order('section').page(params[:page]).per(5)
        end
      #else
      #  @matching_courses = Array.new
      #end
    end
    session[:last_search] = parameters
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
