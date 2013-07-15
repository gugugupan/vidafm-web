class AddShuffleResultToUserShuffles < ActiveRecord::Migration
  def change
    add_column :user_shuffles, :shuffle_result, :integer
  end
end
