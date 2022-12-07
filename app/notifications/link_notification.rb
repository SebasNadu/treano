# To deliver this notification:
#
# LinkNotification.with(post: @post).deliver_later(current_user)
# LinkNotification.with(post: @post).deliver(current_user)

class LinkNotification < Noticed::Base
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
   def message
     @user = User.find(params[:user].id)
     @movie = Movie.find(params[:movie].id)
    return "#{@user.first_name} Don't forget to make the review for #{@movie.title} points"
   end
  #
   def url
     movie_path(params[:movie])
   end
end
