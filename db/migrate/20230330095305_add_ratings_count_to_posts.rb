class AddRatingsCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :ratings_count, :integer
  end
end
