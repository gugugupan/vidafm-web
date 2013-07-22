class CreateUserStatisticTotals < ActiveRecord::Migration
  def change
    create_table :user_statistic_totals do |t|

      t.integer :user_id
      t.integer :create_score
      t.integer :share_score 
  
      t.timestamps
    end
     add_index :user_statistic_totals, :user_id
  end
end
