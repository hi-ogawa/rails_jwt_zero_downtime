class Api::UsersController < ApplicationController
  before_action :require_user!, only: [:me]

  def me
    render json: @current_user.serialize
  end

  def create
    user = User.create(require_params)
    render json: user.serialize
  end

  def require_params
    params.require(:user).permit(:name, :email, :password)
  end
end
