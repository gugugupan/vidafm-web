class ChangeTabelUserShuffles < ActiveRecord::Migration
  def up
    remove_column :user_shuffles, :qq_coin_id
    add_column :user_shuffles, :qq_coin_ids, :string
    add_column :user_shuffles, :shuffle_count, :integer, :default=>0
  end

  def down
  end
end
