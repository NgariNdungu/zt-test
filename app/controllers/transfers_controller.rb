class TransfersController < ApplicationController
  before_action :authenticate_user
  before_action :set_recipient, only: [:create]

  def create  
    if @recipient
      amount = params[:amount]
      @transfer = current_user.sends.new(
        'recipient_id': @recipient.id,
        'amount': amount
      )
      if @transfer.save
        render json: {:id => @transfer.id, :recipient => @transfer.recipient.email, :amount => @transfer.amount}
        # send confirmation email
        TransfersMailer.with(transfer: @transfer).transfer_notification.deliver_now
      else
        render json: @transfer.errors.messages, status: :bad_request
      end
   
    else
      render json: {"recipient" => "Invalid recipient"}, status: :not_found 
    end
  end

  def index
    # method should send email of user transfers
    TransfersMailer.with(user: current_user).transaction_summary.deliver_now
    render json: { "message": "Email sent" }, status: :accepted
  end

  private

  def set_recipient
    if params[:email]
      @recipient = User.find_by(email: params[:email])
    elsif params[:phone]
      @recipient = User.find_by(phone: params[:phone])
    else
      nil
    end    
  end

  def transfer_params
    params.require(:transfer).permit(
      :email,
      :phone,
      :amount
    )
  end
end
