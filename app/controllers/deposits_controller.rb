class DepositsController < ApplicationController
  before_action :authenticate_user

  def index
    render json: build_deposit(current_user.deposits)
  end
  
  def create
    @deposit = current_user.deposits.new(deposit_params)
    if @deposit.save
      render json: @deposit
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
    ret = {}
    deposits.each{ |deposit| 
      ret[deposit[:id]] = {
        "deposited": deposit[:created_at].strftime("%d/%m/%Y at %I:%M%p"),
        "amount": deposit[:amount]
      }
    }
    ret
  end

end
