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
end

# Create application badges (uses https://github.com/norman/ambry)
Rails.application.reloader.to_prepare do
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
  custom_fields: { difficulty: :bronze }
)

Merit::Badge.create!(
  id: 2,
  name: "pro",
  description: "Amazing 10 Lists welcome to the pro team!",
  custom_fields: { difficulty: :silver }
)

Merit::Badge.create!(
  id: 3,
  name: "treano",
  description: "Wow 25 lists you are now in our gold team!!",
  custom_fields: { difficulty: :gold }
)

Merit::Badge.create!(
  id: 4,
  name: "liked",
  description: "Your list have over 5 likes"
)

Merit::Badge.create!(
  id: 5, 
  name: "loved",
  description: "Your lists have over 10 likes"
)

Merit::Badge.create!(
  id: 6,
  name: "revered",
  description: "Your lists have over 25 likes"
)

Merit::Badge.create!(
  id: 7,
  name: "critic",
  description: "Your first review, congratulation!",
  custom_fields: { level: 1 }
)

Merit::Badge.create!(
  id: 8,
  name: "critic",
  description: "5 Reviews a nice beginning!",
  custom_fields: { level: 2 }
)

Merit::Badge.create!(
  id: 9,
  name: "critic",
  description: "10 Reviews you rocks!",
  custom_fields: { level: 3 }
)

Merit::Badge.create!(
  id: 10,
  name: "critic",
description: "25 Reviews Mr. Critic",
  custom_fields: { level: 4 }
)

Merit::Badge.create!(
  id: 11,
  name: "judgemental",
  description: "You have saved a list"
)

Merit::Badge.create!(
  id: 12,
  name: "critic",
  description: "50 Reviews Dr. Critic",
  custom_fields: { level: 5 }
)

Merit::Badge.create!(
  id: 13,
  name: "critic",
  description: "50 Reviews you are a Critic master!",
  custom_fields: { level: 6 }
)

Merit::Badge.create!(
  id: 14,
  name: "pioneer",
  description: "Welcome to treano!!",
)
#Merit::Badge.create!(
  #id: 16,
  #name: "schadenfreude",
  #description: "Achtung! You have enjoyed the misfortune of another"
#)

end
