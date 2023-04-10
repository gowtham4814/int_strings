class Post < ApplicationRecord
  scope :between_dates, -> (from_date, to_date) {
    from_date = from_date.to_date
    to_date = to_date.to_date.tomorrow
    where(created_at: from_date..to_date)
  }

  belongs_to :topic
  has_many :comments,dependent: :destroy, counter_cache: :comments_count
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags
  has_many :ratings, dependent: :destroy, counter_cache: :ratings_count
  has_one_attached :image
  has_and_belongs_to_many :users,join_table: :posts_users
  validates :title, length: { maximum: 20 }
end
