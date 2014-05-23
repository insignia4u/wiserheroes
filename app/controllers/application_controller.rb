class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def favoriter
    @favoriter ||= Favoriter.new(current_user)
  end
  helper_method :favoriter

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
