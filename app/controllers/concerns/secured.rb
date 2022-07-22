module Secured
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  def authenticate_user!
    redirect_to '/' unless session[:userinfo].present?
  end
end
