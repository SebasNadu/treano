# To deliver this notification:
#
# PointsNotification.with(post: @post).deliver_later(current_user)
# PointsNotification.with(post: @post).deliver(current_user)

class PointsNotification < Noticed::Base
  # Add your delivery methods
  #
   deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:post])
  # end

  def message
    @user = User.find(params[:user].id || current_user.id)
    @granted_at = params[:granted_at]
    @points = params[:points]
    return "#{@user.first_name} new score: #{@points.num_points} points"
  end

  def url
    user_dashboard_path(params[:user])
  end

end
