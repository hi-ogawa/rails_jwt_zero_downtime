module ControllerHelper
  def mock_login(user)
    request.headers["Authorization"] = user.generate_token
  end
end
