class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :set_notifications, if: :current_user

  private

  def set_notifications
    notifications = Notification.where(recipient_id: current_user.id).newest_first.limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end

end
