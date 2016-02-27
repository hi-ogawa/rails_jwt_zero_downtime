class Api::StatusController < ApplicationController

  def show
    render json: {status: 'ok'}
  end
end
