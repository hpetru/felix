class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def require_login
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
