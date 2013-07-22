class AddQqCoinIdToUserShuffer < ActiveRecord::Migration
  def change
    add_column :user_shuffles, :qq_coin_id, :integer
  end
end
