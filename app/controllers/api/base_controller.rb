class Api::BaseController < ApplicationController

  def route_not_found
    head :not_found
  end
end
