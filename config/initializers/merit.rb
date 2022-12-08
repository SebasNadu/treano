# Use this hook to configure merit parameters
#Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grant badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
Merit.setup do |config|
  config.checks_on_each_request = true
  config.orm = :active_record
  
  config.user_model_name = 'User'
  config.current_user_method = 'current_user'
  config.add_observer 'NewBadgeObserver'
  config.add_observer 'NewPointsObserver'
end


Rails.application.reloader.to_prepare do

module Merit::Models::ActiveRecord
  # Sash is a container for reputation data for meritable models. It's an
  # indirection between meritable models and badges and scores (one to one
  # relationship).
  #
  # It's existence make join models like badges_users and scores_users
  # unnecessary. It should be transparent at the application.
  class Sash < ActiveRecord::Base
    include Merit::Models::SashConcern

    has_many :badges_sashes, dependent: :destroy
    has_many :scores, dependent: :destroy, class_name: 'Merit::Score'

    has_noticed_notifications model_name: 'Notification'
    has_many :notifications, through: :user, dependent: :destroy

    after_create :create_scores

    # Retrieve all points from a category or none if category doesn't exist
    # By default retrieve all Points
    # @param category [String] The category
    # @return [ActiveRecord::Relation] containing the points
    def score_points(options = {})
      scope = Merit::Score::Point
                .joins(:score)
                .where('merit_scores.sash_id = ?', id)
      if (category = options[:category])
        scope = scope.where('merit_scores.category = ?', category)
      end
      scope
    end
  end
end

class Merit::Sash < Merit::Models::ActiveRecord::Sash; end

module Merit::Models::ActiveRecord
  class BadgesSash < ActiveRecord::Base
    include Merit::Models::BadgesSashConcern

    has_many :activity_logs,
             class_name: 'Merit::ActivityLog',
             as: :related_change

    before_destroy :cleanup_notifications
    has_noticed_notifications model_name: 'Notification'

    validates_presence_of :badge_id, :sash

  def cleanup_notifications
    notifications_as_merit_models_active_record_badges_sash.destroy_all
  end

  end
end

class Merit::BadgesSash < Merit::Models::ActiveRecord::BadgesSash; end


# Create application badges (uses https://github.com/norman/ambry)
#   badge_id = 0
#   [{
#     id: (badge_id = badge_id+1),
#     name: 'just-registered'
#   }, {
#     id: (badge_id = badge_id+1),
#     name: 'best-unicorn',
#     custom_fields: { category: 'fantasy' }
#   }].each do |attrs|
#     Merit::Badge.create! attrs
#   end


Merit::Badge.create!(
  id: 1,
  name: "rookie",
  description: "You create a list welcome to the rookie team!",
  custom_fields: { difficulty: :bronze, image: 'Bronze Medal.png' }
)

Merit::Badge.create!(
  id: 2,
  name: "pro",
  description: "Amazing 10 Lists welcome to the pro team!",
  custom_fields: { difficulty: :silver, image: 'Silver Medal.png' }
)

Merit::Badge.create!(
  id: 3,
  name: "treano",
  description: "Wow 25 lists you are now in our gold team!!",
  custom_fields: { difficulty: :gold, image: 'Gold Medal.png' }
)

Merit::Badge.create!(
  id: 4,
  name: "liked",
  description: "Your list have over 5 likes",
  custom_fields: { image: 'Medal Blue 2.png' }
)

Merit::Badge.create!(
  id: 5, 
  name: "loved",
  description: "Your lists have over 10 likes",
  custom_fields: { image: 'Medal Purple.png' }
)

Merit::Badge.create!(
  id: 6,
  name: "revered",
  description: "Your lists have over 25 likes",
  custom_fields: { image: 'Medal Red.png' }
)

Merit::Badge.create!(
  id: 7,
  name: "critic",
  description: "Your first review, congratulation!",
  custom_fields: { level: 1, image: 'Award 1.png' }
)

Merit::Badge.create!(
  id: 8,
  name: "critic",
  description: "5 Reviews a nice beginning!",
  custom_fields: { level: 2, image: 'Award 2.png' }
)

Merit::Badge.create!(
  id: 9,
  name: "critic",
  description: "10 Reviews you rocks!",
  custom_fields: { level: 3, image: 'Award 3.png' }
)

Merit::Badge.create!(
  id: 10,
  name: "critic",
  description: "25 Reviews Mr. Critic",
  custom_fields: { level: 4, image: 'Award 4.png' }
)

Merit::Badge.create!(
  id: 11,
  name: "judgemental",
  description: "You have saved a list",
  custom_fields: { image: 'Medal Blue.png' }
)

Merit::Badge.create!(
  id: 12,
  name: "critic",
  description: "50 Reviews Dr. Critic",
  custom_fields: { level: 5, image: 'Award 5.png' }
)

Merit::Badge.create!(
  id: 13,
  name: "critic",
  description: "100 Reviews you are a Critic master!",
  custom_fields: { level: 6, image: 'Award 6.png' }
)

Merit::Badge.create!(
  id: 14,
  name: "pioneer",
  description: "Welcome to treano!!",
  custom_fields: { level: 6, image: 'Award 1.png' }
)
#Merit::Badge.create!(
  #id: 16,
  #name: "schadenfreude",
  #description: "Achtung! You have enjoyed the misfortune of another"
#)

end
