class AddColumnsToUserStatisticTotal < ActiveRecord::Migration
  def change
   add_column :user_statistic_totals, :create_count, :integer, :default=>0 
   add_column :user_statistic_totals, :create_played_count, :integer, :default=>0 
   add_column :user_statistic_totals, :shared_count, :integer, :default=>0 
   add_column :user_statistic_totals, :shared_played_count, :integer, :default=>0 

   add_column :user_statistic_totals, :create_moment_ids, :string 
   add_column :user_statistic_totals, :share_moment_ids, :string
  end
end
