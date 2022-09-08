class DashboardController < ApplicationController
  before_action :require_login
  
  def index 

  end

  private 
    def require_login
      unless current_user 
        redirect_to root_path 
        flash[:error] = 'You must be logged in or registered to access the dashboard.'
      end 
    end
end