class ChangeColumnUserStatisticTotal < ActiveRecord::Migration
  def up
    change_column :user_statistic_totals, :create_moment_ids, :text
    change_column :user_statistic_totals, :share_moment_ids, :text
  end

  def down
  end
end
