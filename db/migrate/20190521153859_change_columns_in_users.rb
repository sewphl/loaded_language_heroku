class ChangeColumnsInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :provider, :string, true
    add_index :users, [:provider, :uid], unique: true
  end
end
