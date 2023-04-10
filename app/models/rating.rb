class Rating < ApplicationRecord
  after_save :rating_calculation
  after_destroy :rating_calculation
  belongs_to :post, counter_cache: :ratings_count, touch: true

  private

  def rating_calculation
    @rating = post.ratings.average(:rating)
    if @rating.present?
    @average = @rating.round(1)
    post.update(average_rating: @average)
    else
    post.update(average_rating: @rating)
    end
  end
end
