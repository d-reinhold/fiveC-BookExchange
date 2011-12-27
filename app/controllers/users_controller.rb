class UsersController < ApplicationController
  before_filter :authenticate_user, :only => [:show, :edit, :update] 
  before_filter :correct_user, :only => [:show, :edit, :update]  
   
  def show
    @title = @current_user.name
    @listings = @current_user.listings
    @seller_transactions = Array.new
    @current_user.listings.each do |l|
      if l.transaction.status == 'unavailable'
        @seller_transactions << l.transaction
      end
    end  
    @buyer_transactions = Transaction.where('buyer_email = ?', @current_user.email)
  end 
      
  def new
    @title = 'Sign up'
    @user = User.new

  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      if @user.listings.empty?
        flash[:success] = "Welcome to the 5C Book Exchange!"
      else
        flash[:success] = "Welcome to the 5C Book Exchange! \n Your listing has been posted"
      end
      session[:user_id] = @user.id
      redirect_to @user
    else
      message = 'Your account could not be created!'
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
    puts params[:email_checker]
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
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end  
    

  

end
