class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  private

  # Before filters

  # Confirms a logged-in user.
  # disable style/guard
  def logged_in_user
    unless logged_in?

      # Calls store location in app/helpers/sessions_helper.rb
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end
end
