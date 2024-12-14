# app/controllers/admin/application_controller.rb
module Admin
  class ApplicationController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!

    private

    def authorize_admin!
      unless current_user&.admin?
        redirect_to new_user_session_path, alert: "Access Denied! Please log in as an admin to continue."
      end
    end
  end
end

