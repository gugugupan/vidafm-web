class AddUserIdToMomentStatistics < ActiveRecord::Migration
  def change
    add_column :moment_statistics, :user_id, :integer
    add_index :moment_statistics, :user_id
  end

end
