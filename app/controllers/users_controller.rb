class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :show]
  def create
    @user = User.new(user_params)
     if @user.save
       "Account created"
     else
       "Invalid inputs"
     end
  end

  def show
    @user
  end

  def destroy
   if @user.destroy!
     "Account deleted"
   end
  end

  def update
    if @user.update(user_params)
      "Account updated"
    else
      "Invalid inputs"
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :phone,
      :password,
      :password_confirmation
    )    
  end

  def set_user
    @user = current_user
  end
end
