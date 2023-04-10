class AddUserRefToRatings < ActiveRecord::Migration[6.1]
  def change
    add_reference :ratings, :user, foreign_key: true, default: nil
  end
end
