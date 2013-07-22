class AddSharingUserIdToMomentStatistics < ActiveRecord::Migration
  def change
    add_column :moment_statistics, :sharing_user_id, :integer
    add_index :moment_statistics, :sharing_user_id
  end
end
