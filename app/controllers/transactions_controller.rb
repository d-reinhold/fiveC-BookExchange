class TransactionsController < ApplicationController
  
  def request_book
    puts params
    @transaction = Transaction.find(params[:id])
    if @transaction.status == 'available'
      @transaction.buyer_email = params[:buyer_email]
      @transaction.status = "unavailable"
      if @transaction.save
        flash[:success] = "Transaction initiated! Check your email for more information."
        if signed_in?
          redirect_to @current_user
        else
          redirect_to root_path
        end
      else
        message = @transaction.errors.full_messages
        flash[:error] = message
        redirect_to root_path
      end
    else 
      flash[:error] = "This listing is no longer available."
      redirect_to root_path
    end
  end

  def cancel_request
    
    
  end

end
