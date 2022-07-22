class ApplicationController < ActionController::Base
  def authenticate_user!
    redirect_to '/' unless session[:userinfo].present?
  end
end
