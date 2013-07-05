class AddColumnToUserStatistic < ActiveRecord::Migration
  def change
    add_column :user_statistics,:create_score,:integer
    add_column :user_statistics,:share_score, :integer
    
    add_index :user_statistics, :create_score
    add_index :user_statistics, :share_score
  end
end
