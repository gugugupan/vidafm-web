class AddColumnToMomentStatistic < ActiveRecord::Migration
  def change
    add_column :moment_statistics, :total_score, :integer

    add_index :moment_statistics, :total_score
  end
end
