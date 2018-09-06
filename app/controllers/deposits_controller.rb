class DepositsController < ApplicationController
  include TransfersMailerHelper
  before_action :authenticate_user

  def index
    render json: build_deposit(current_user.deposits)
  end
  
  def create
    @deposit = current_user.deposits.new(deposit_params)
    if @deposit.save
      render json: build_deposit([@deposit])
    else
      render json: @deposit.errors.messages 
    end  
  end

  private

  def deposit_params
    params.require(:deposit).permit(      
      :amount
    )
  end

  def build_deposit(deposits)
    deposits_arr = []
    deposits.each{ |deposit| 
      deposits_arr.push(deposit[:id].to_s => {
        "deposited": format_time(deposit[:created_at]),
        "amount": deposit[:amount]
      })
    }
    deposits_arr 
  end

end
