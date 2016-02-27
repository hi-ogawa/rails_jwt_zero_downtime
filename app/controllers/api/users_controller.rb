class Api::UsersController < ApplicationController
  before_action :require_user!, only: [:me]

  def me
    render json: @current_user.serialize
  end
end
