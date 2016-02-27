class Api::AuthController < ApplicationController

  def login
    if user = User.login(require_params)
      render json: user.serialize.merge(token: user.generate_token)
    else
      head :unauthorized
    end
  end

  def require_params
    params.require(:auth).permit(:email, :password)
  end
end
