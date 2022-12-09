class NewPointsObserver
  def update(changed_data)
    return unless changed_data[:merit_object].is_a?(Merit::Score::Point)

      user = User.find_by(sash_id: changed_data[:sash_id])
      points = changed_data[:merit_object]
      granted_at = changed_data[:granted_at]
      sash_id = changed_data[:sash_id]
      description = changed_data[:description]

      noti = PointsNotification.with(points: points, granted_at: granted_at, sash_id: sash_id, description: description).deliver(user)

    #BadgeMailer.earned_badge(user, badge, granted_at).deliver_later
  end
end
