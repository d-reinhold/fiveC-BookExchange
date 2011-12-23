class SessionsController < ApplicationController
  def new
    @title = 'Sign in'
  end

  def create
    puts "begin authentication"
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      puts "Authenticated!"
      session[:user_id] = user.id
      @current_user = user
      respond_to do |format|
        format.html{
          flash[:success] = "Signed in!"
          redirect_to root_url
        }
        format.js
      end
    else
      puts "Authentication failed!"
      respond_to do |format|
        format.html{
          flash.now[:error] = "Invalid email or password"
          render "new"
        }
        format.js
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Signed out!'
    redirect_to root_url
  end
end
