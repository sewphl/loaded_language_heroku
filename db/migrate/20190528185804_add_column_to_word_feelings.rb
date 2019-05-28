class AddColumnToWordFeelings < ActiveRecord::Migration[5.2]
  def change
    add_column :word_feelings, :user_id, :integer
  end
end
