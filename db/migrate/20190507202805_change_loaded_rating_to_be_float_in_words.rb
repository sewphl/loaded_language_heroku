class ChangeLoadedRatingToBeFloatInWords < ActiveRecord::Migration[5.2]
  def change
    change_column :words, :loaded_rating, :float
  end
end
