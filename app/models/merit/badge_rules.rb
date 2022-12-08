# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # Find badge by badge_id, badge_id takes presidence over badge
      # grant_on 'users#create', badge_id: 7, badge: 'just-registered', to: :itself

      # If it has 10 comments, grant commenter-10 badge
      # grant_on 'comments#create', badge: 'commenter', level: 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end

    # Review badges
      grant_on ['reviews#create', 'reviews#update'], badge_id: 7, to: :action_user, temporary: true, mulitple: true, model_name: 'Review' do |review|
        review.user && review.user.reviews.count > 0 && review.user.reviews.count <= 4
      end

      grant_on ['reviews#create', 'reviews#update'], badge_id: 8, to: :action_user, temporary: true, mulitple: true, model_name: 'Review' do |review|
        review.user && review.user.reviews.count > 4 && review.user.reviews.count <= 9
      end

      grant_on ['reviews#create', 'reviews#update'], badge_id: 9, to: :action_user, temporary: true, mulitple: true, model_name: 'Review' do |review|
        review.user && review.user.reviews.count > 9 && review.user.reviews.count <= 24
      end

      grant_on ['reviews#create', 'reviews#update'], badge_id: 10, to: :action_user, temporary: true, mulitple: true, model_name: 'Review' do |review|
        review.user && review.user.reviews.count > 24 && review.user.reviews.count <= 50
      end

      grant_on ['reviews#create', 'reviews#update'], badge_id: 12, to: :action_user, temporary: true, mulitple: true, model_name: 'Review' do |review|
        review.user && review.user.reviews.count > 50 && review.user.reviews.count <= 100
      end

      grant_on ['reviews#create', 'reviews#update'], badge_id: 13, to: :action_user, temporary: true, mulitple: true, model_name: 'Review' do |review|
        review.user && review.user.reviews.count > 100
      end

      # List badges

      grant_on ['lists#create', 'lists#update'], badge_id: 1, to: :action_user, temporary: true, mulitple: true, model_name: 'List' do |list|
        list.user.lists.count > 0 && list.user.lists.count <= 9
      end

      grant_on ['lists#create', 'lists#update'], badge_id: 2, to: :action_user, temporary: true, mulitple: true, model_name: 'List' do |list|
        list.user && list.user.lists.count > 9 && list.user.lists.count <= 24
      end

      grant_on ['lists#create', 'lists#update'], badge_id: 3, to: :action_user, temporary: true, mulitple: true, model_name: 'List' do |list|
        list.user && list.user.lists.count > 25
      end

      # lists likes
      grant_on ['lists#toggle_favorite', "lists#untoggle"], badge_id: 11, mulitple: true, to: :action_user, temporary: true, badge: 'judgemental', model_name: 'List' do |list|
        list.user && list.user.favorites.count > 0 && list.user.list.favorites.count <= 4
      end

      grant_on ['lists#toggle_favorite', 'lists#untoggle'], badge_id: 4, mulitple: true, to: :user, temporary: true, badge: 'liked', model_name: 'List' do |list|
        list.user && list.user.favorites.count > 4 && list.user.favorites.count <=9
      end

      grant_on ['lists#toggle_favorite', 'lists#untoggle'], badge_id: 5, mulitple: true, to: :user, temporary: true, badge: 'loved', model_name: 'List' do |list|
        list.user && list.user.favorites.count > 9 && list.user.favorites.count <= 24
      end

      grant_on ['lists#toggle_favorite', 'lists#untoggle'], badge_id: 6, mulitple: true, to: :user, temporary: true, badge: 'revered', model_name: 'List' do |list|
        list.user && list.user.favorites.count > 24
      end

    end
  end
end
