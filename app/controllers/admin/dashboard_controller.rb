class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
  end

  private

  def ensure_admin
    # Replace `admin@example.com` with the email of the sole admin
    unless current_user && current_user.email == "admin@example.com"
      redirect_to root_path, alert: "Access denied."
    end
  end
end

