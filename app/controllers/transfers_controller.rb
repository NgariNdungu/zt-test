class TransfersController < ApplicationController
  before_action :authenticate_user

  def create  
    if params[:email]
      @recipient = User.find_by(email: params[:email])
    elsif params[:phone]
      @recipient = User.find_by(phone: params[:phone])
    else
      render json: { "messages": "email or phone is required" }, status: :bad_request
      return
    end
    amount = params[:amount] # if current_user.balance > params[:amount].to_i 
    @transfer = current_user.sends.new(
      'recipient_id': @recipient.id,
      'amount': amount
    )
    if @transfer.save
      render json: @transfer
    else
      render json: @transfer.errors.messages, status: :bad_request
    end
  end

  def index
    # method should send email of user transfers
    render json: { "message": "Email sent" }, status: :accepted
  end

  private
  def transfer_params
    params.require(:transfer).permit(
      :email,
      :phone,
      :amount
    )
  end
end
