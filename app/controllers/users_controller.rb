class UsersController < ApplicationController
  before_filter :authenticate_user, :only => [:show, :edit, :update] 
  before_filter :correct_user, :only => [:show, :edit, :update]  
   
  def show
    session[:from_search] = false
    @title = @current_user.name
    @listings = @current_user.listings
    @seller_transactions = Array.new
    @seller_transactions_final = Array.new
    @current_user.listings.each do |l|
      if l.transaction.status == 'unavailable'
        @seller_transactions << l.transaction
      elsif l.transaction.status == 'sold'
        @seller_transactions_final << l.transaction
      end
    end  
    @buyer_transactions = Transaction.where('buyer_email = ? AND status = ?', @current_user.email, 'unavailable')    
    @buyer_transactions_final = Transaction.where('buyer_email = ? AND status = ?', @current_user.email, 'sold')
  end 
      
  def new
    @title = 'Sign up'
    @user = User.new

  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.welcome_email(@user).deliver
      if @user.listings.empty?
        flash[:success] = "Welcome to the 5C Book Exchange!"
      else
        @listing = @user.listings.first
        @book = Book.where("lower(title) LIKE ?", "%#{@listing.title.downcase}%").limit(1).all
        unless @book.empty?
          puts 'Found a course that requires this book!'
          @listing.book_id = @book.first.id
          @listing.save
        end
        flash[:success] = "Welcome to the 5C Book Exchange! Your listing has been posted!"
      end
      session[:user_id] = @user.id
      redirect_to @user
    else
      if User.find_by_email(params[:user][:email]).present?
        message = 'That email address is already registered! Try signing in!'
      else
        message = 'Please correct the following errors:  '+ @user.errors.full_messages.to_s
      end
      flash[:error] = message
      redirect_to signup_path
    end
  end
  
  def edit
      #@user = User.find(params[:id])
      @title = "Settings"
  end
  
  def update
    puts 'UPDATE DEBUG!!!!'
    @user = User.find(params[:id])
    if @user.update_attributes!(params[:user])
      flash[:success] = "Account updated!"
      redirect_to @user
    else
      message = 'Your account could not be updated!'
      flash[:error] = message
      redirect_to root_path
    end
  end  
  
  def check_email
    puts "Checking email now.."
    puts params
    @user = User.find_by_email(params[:email_checker])
    if @user.nil?
      puts "Email not registered, creating a new user"
      @user = User.new
      @user.listings.new
    else
      puts "Email already taken"
      @listing = @user.listings.new
    end
    respond_to do |format|
      format.js
    end
  end
  
  private


    def correct_user
      unless User.exists?(:id => params[:id])
        flash[:error] = 'That account does not exist.'
        redirect_to root_path
        return
      else
        @user = User.find(params[:id])
      end
      unless current_user?(@user)
        flash[:error] = "You don't have permission to view that page."
        redirect_to(root_path) 
      end
    end  
    

  

end
