module SpecTestHelper
  def login(user)
    user = User.where(:id => user.id).first
    request.session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

   def current_user_resource_owner resource
    current_user_temp=current_user
    @current_user ||= current_user_temp if current_user_temp and current_user_temp == resource.user
  end
end
