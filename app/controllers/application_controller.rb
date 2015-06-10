class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_user_resource_owner

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/login' unless current_user
  end

   def current_user_resource_owner resource
    current_user_temp=current_user
    @current_user ||= current_user_temp if current_user_temp and current_user_temp == resource.user
  end

   def require_user_resource_owner resource
    redirect_to '/restricted' unless current_user_resource_owner resource
  end

end
