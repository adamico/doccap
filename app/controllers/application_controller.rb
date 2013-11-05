class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  enable_authorization unless: :devise_controller?

  rescue_from CanCan::Unauthorized do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to login_url, alert: exception.message
  end
end
