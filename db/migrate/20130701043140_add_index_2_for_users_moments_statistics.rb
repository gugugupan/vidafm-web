class AddIndex2ForUsersMomentsStatistics < ActiveRecord::Migration
  def up
   add_index :moment_statistics, :created_at
   add_index :user_statistics, [:created_at,:user_id]
  end

  def down
  end
end
