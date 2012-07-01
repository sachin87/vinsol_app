class ApplicationController < ActionController::Base

  protect_from_forgery

  include ApplicationHelper
  
  before_filter :find_current_user
  
  def find_current_user
    unless current_user
      redirect_to new_user_path
    end
  end
      
end