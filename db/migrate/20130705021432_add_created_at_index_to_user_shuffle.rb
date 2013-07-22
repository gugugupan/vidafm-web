class AddCreatedAtIndexToUserShuffle < ActiveRecord::Migration
  def change
   add_index :user_shuffles, :created_at
  end
end
