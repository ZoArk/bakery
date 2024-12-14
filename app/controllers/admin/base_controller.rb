class Admin::BaseController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in
  before_action :ensure_admin       # Check if the user is an admin

  private

  def ensure_admin
    unless current_user&.admin? # Assuming you have an `admin?` method in your User model
      redirect_to root_path, alert: "Access denied!"
    end
  end
end
