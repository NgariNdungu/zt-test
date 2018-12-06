class CallbackController < ApplicationController
  def create
    render json: params
  end
end
