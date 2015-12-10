class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper


  # Sets the current_user to be accessed by the model
  include PublicActivity::StoreController
  def c_user
    @c_user ||= current_user
  end
  helper_method :c_user
  hide_action :c_user
end
