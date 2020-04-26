class AddUserToList < ActiveRecord::Migration[6.0]
  def change
    add_reference :lists, :user, foreign_key: true
    change_column :lists, :user_id, :integer, null: false
  end
end
