class DropLoadedRatingColumnFromWords < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :loaded_rating
  end
end
