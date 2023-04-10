class Comment < ApplicationRecord
  belongs_to :post, counter_cache: :comments_count, touch: true
  has_many :commentratings, dependent: :destroy
  has_many :users, through: :commentratings
end
