class AddIndexForUserStatistics < ActiveRecord::Migration
  def up
    add_index :user_statistic_totals, :is_award
  end

  def down
  end
end
