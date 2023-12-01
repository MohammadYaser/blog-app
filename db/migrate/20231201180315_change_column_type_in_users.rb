class ChangeColumnTypeInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :photo, :string
  end
end
