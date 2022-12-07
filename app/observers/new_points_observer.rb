class NewPointsObserver
  def update(changed_data)
    return unless changed_data[:merit_object].is_a?(Merit::Score::Point)

      user = User.where(sash_id: changed_data[:sash_id]).first
      points = changed_data[:merit_object]
      granted_at = changed_data[:granted_at]

      noti = PointsNotification.with(user: user, points: points, granted_at: granted_at)
      noti.deliver_later(user)

    #BadgeMailer.earned_badge(user, badge, granted_at).deliver_later
  end
end
