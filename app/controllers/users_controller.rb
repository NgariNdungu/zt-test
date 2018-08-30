class UsersController < ApplicationController
  before_action :authenticate_user, only: [:update, :destroy, :show]
  before_action :set_user, only: [:update, :destroy, :show]

  def create
    @user = User.new(user_params)
     if @user.save
       render json: user_profile(@user)  
     else
       render json: @user.errors.messages, status: :bad_request 
     end
  end

  def show
    render json: user_profile(@user)
  end

  def destroy
   if @user.destroy!
     render status: :no_content 
   end
  end

  def update
    if @user.update(user_params)
      render json: user_profile(@user)
    else
      render json: @user.error.messages, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :name,
      :phone,
      :password,
      :password_confirmation
    )    
  end

  def set_user
    @user = current_user
  end

  # filter user parameters
  def user_profile(user)
    profile = user.slice(:id, :name, :email, :phone)
  end
end
