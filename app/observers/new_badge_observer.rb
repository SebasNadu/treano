class NewBadgeObserver
  def update(changed_data)
    #return unless changed_data[:merit_object].is_a?(Merit::BadgesSash)
    #return unless changed_data[:merit_object].is_a?(Merit::Score::Point)

    if changed_data[:merit_object].is_a?(Merit::BadgesSash)
      user = User.where(sash_id: changed_data[:sash_id]).first
      badge = changed_data[:merit_object]
      description = changed_data[:description]
      granted_at = changed_data[:granted_at]
      notification = BadgeNotification.with(user: user, badge: badge, granted_at: granted_at, description: description)
      notification.deliver_later(user)
    elsif changed_data[:merit_object].is_a?(Merit::Score::Point)
      user = User.where(sash_id: changed_data[:sash_id]).first
      points = changed_data[:merit_object]
      granted_at = changed_data[:granted_at]
      notification = PointsNotification.with(user: user, points: points, granted_at: granted_at)
      notification.deliver_later(user)
    end
    #BadgeMailer.earned_badge(user, badge, granted_at).deliver_now
  end
end
