class TransfersController < ApplicationController
  before_action :authenticate_user

  def create
    @transfer = current_user.transfers.new(transfer_params)
    if @transfer.save
      render json: @transfer
    else
      render json: @transfer.errors.messages
    end
  end

  def index
    # method should send email of user transfers
    render status: ':accepted'
  end

  private
  def transfer_params
    params.require(:transfer).permit(
      :recipient_id,
      :amount
    )
  end
end
