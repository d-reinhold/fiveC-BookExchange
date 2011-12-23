class ListingsController < ApplicationController
  def show
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
  end

  def update
  end

  def destroy
  end

  def index
  end

end
