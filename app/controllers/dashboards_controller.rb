class DashboardsController < ApplicationController
  include Secured

  def show
    render json: session[:userinfo]
  end
end
