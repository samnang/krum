class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin_signed_in?
  def admin_signed_in?
    !!session[:admin]
  end

  def admin_required
    redirect_to admin_path unless admin_signed_in?
  end

  def admin_sign_in
    if authenticate_or_request_with_http_basic do |user_name, password|
        admin_name = Krum.config.username
        admin_password = Krum.config.password
        if user_name == admin_name && password == admin_password
          session[:admin] = true
          redirect_to root_path and return true
        end
      end
    end
  end
end
