module ApplicationHelper
  def admin_user?
    current_user && current_user.email == "admin@example.com"
  end
end
