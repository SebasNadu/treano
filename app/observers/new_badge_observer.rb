class NewBadgeObserver
  def update(changed_data)
    #return unless changed_data[:merit_object].is_a?(Merit::BadgesSash)

    #user = User.where(sash_id: changed_data[:sash_id]).first
    #badge = changed_data[:merit_object].badge
    #description = changed_data[:description]
    #granted_at = changed_data[:granted_at]
    return unless changed_data[:merit_object].is_a?(Merit::BadgesSash)

    user = User.find_by(sash_id: changed_data[:sash_id])
    badge = changed_data[:merit_object]
    granted_at = changed_data[:granted_at]
    sash_id = changed_data[:sash_id]
    description = changed_data[:description]

    noti = BadgeNotification.with(badge: badge, granted_at: granted_at, description: description, sash_id: sash_id).deliver(user)

    #BadgeMailer.earned_badge(user, badge, granted_at).deliver_later
  end
end
