class ApplicationController < ActionController::Base
  before_action :current_session
  def current_session
    return unless session[:user_id]

    Current.user = User.find_by(id: session[:user_id])
  end

  def user_not_logged
    return  unless Current.user.nil?

    redirect_to login_path, alert: 'You must be logged in to continue'
  end
end
