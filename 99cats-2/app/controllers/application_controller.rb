class ApplicationController < ActionController::Base
  helper_method :current_user, :login?
  protect_from_forgery with: :exception

  def current_user
    return nil unless sessions[:session_token]
    @current_user ||= User.find_by(session_token: sessions[:session_token])
  end

  def login!(user)
    sessions[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token!
    sessions[:session_token] = nil
  end

  def login?
    !!current_user
  end

  def require_logged_in
    redirect_to new_session_url unless login?
  end

  def require_logged_out
    redirect_to root_url if login?
  end

end
