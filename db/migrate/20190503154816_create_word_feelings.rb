class CreateWordFeelings < ActiveRecord::Migration[5.2]
  def change
    create_table :word_feelings do |t|
      t.integer :word_id
      t.integer :feeling_id
      t.float :feeling_rating

      t.timestamps
    end
  end
end
