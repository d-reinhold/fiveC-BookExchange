class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end 
      
  def new
    @title = 'Sign up'
    @user = User.new

  end
  
  def create
    @user = User.new(params[:user])
    if @user.save!
      flash[:success] = "Welcome!"
      session[:user_id] = @user.id
      redirect_to @user
    else
      message = 'Your account could not be created!'
      flash[:error] = message
      redirect_to root_path
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

end
