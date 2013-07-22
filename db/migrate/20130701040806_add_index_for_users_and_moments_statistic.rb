class AddIndexForUsersAndMomentsStatistic < ActiveRecord::Migration
  def up
    add_index :moment_statistics, :moment_id
    add_index :user_statistics, :user_id
  end

  def down
  end
end
