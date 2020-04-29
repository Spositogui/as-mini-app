class CreateJoinTableFavoriteList < ActiveRecord::Migration[6.0]
  def change
    create_join_table :favorites, :lists do |t|
      t.index [:favorite_id, :list_id]
    end
  end
end
