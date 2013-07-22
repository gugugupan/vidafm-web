class AddColumnsToUserStatisticTotals < ActiveRecord::Migration
  def change
    add_column :user_statistic_totals, :is_award, :boolean, :default=>false
    add_column :user_statistic_totals, :award_type, :integer, :default=>1
    add_column :user_statistic_totals, :award_time, :datetime
    add_column :user_statistic_totals, :award_share_url, :string
  end
 
end
