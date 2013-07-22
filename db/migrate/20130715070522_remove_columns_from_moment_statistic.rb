class RemoveColumnsFromMomentStatistic < ActiveRecord::Migration
  def up
    remove_column :moment_statistics, :sharing_user_id
  end

  def down
  end
end
