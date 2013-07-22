class RemoveColumForUserShuffle < ActiveRecord::Migration
  def up
    remove_column :user_shuffles, :qq_coin_ids
    remove_column :user_shuffles, :shuffle_count 
    add_column :user_shuffles, :qq_coin_id, :integer
  end

  def down
  end
end
