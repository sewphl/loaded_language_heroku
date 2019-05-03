class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :entry
      t.float :loaded_rating

      t.timestamps
    end
  end
end
