class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # handle exception from params.require(...).permit(...)
  rescue_from ActionController::ParameterMissing do |e|
    head :bad_request
  end

  def require_user!
    unless @current_user = User.find_from_token(request.headers["Authorization"] || "")
      return head :unauthorized
    end
  end
end
