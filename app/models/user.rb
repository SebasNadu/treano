class User < ApplicationRecord
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_one_attached :avatar

  has_many :lists, dependent: :delete_all
  has_many :user_challenges, dependent: :delete_all
  has_many :challenges, through: :user_challenges
  has_many :user_providers
  has_many :providers, through: :user_providers
  has_many :reviews, dependent: :delete_all

  has_many :movies, through: :reviews, source: :reviewable, source_type: 'Movie'
  has_many :tvs, through: :reviews, source: :reviewable, source_type: 'Tv'

  acts_as_favoritable
  acts_as_favoritor

  scope :top, ->(n){ joins('LEFT JOIN merit_scores ON merit_scores.sash_id = users.sash_id ' \
                      'LEFT JOIN merit_score_points ON merit_score_points.score_id = merit_scores.id')
                      .group('users.id', 'merit_scores.sash_id').order('SUM(num_points) DESC')
                      .limit(n)
                    }

  after_update :process_badges

  def lists_rep_name
    ((badge_names & ['rookie', 'pro', 'minnesotan']).first || 'N/A').capitalize
  end

  def badge_names
    @badge_names ||= badges.map(&:name)
  end

  def has_badge?(badge_id)
    !find_badge(badge_id).nil?
  end

  def find_badge(badge_id)
    badges.select{|b| b.id == badge_id}.first
  end

end
