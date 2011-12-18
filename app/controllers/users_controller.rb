class UsersController < ApplicationController
  
  def show
    @user = User.find(:params[:user_id])
    @title = @user.name
  end  
      
  def new
    @title = 'Sign up'
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the 5C Book Exchange!"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
      @user = User.find(params[:id])
      @title = "Settings"
    end
  
  
end
