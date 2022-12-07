# To deliver this notification:
#
# BadgeNotification.with(post: @post).deliver_later(current_user)
# BadgeNotification.with(post: @post).deliver(current_user)

class BadgeNotification < Noticed::Base
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
    @user = User.find(params[:user].id)
    @granted_at = params[:granted_at]
    @badge = params[:badge]
    @description = params[:description]
    return "#You win the #{@description}!"
  end

  def url
    user_dashboard_path(params[:user])
  end

end
