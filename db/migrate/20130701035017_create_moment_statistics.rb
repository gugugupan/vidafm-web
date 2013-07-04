class CreateMomentStatistics < ActiveRecord::Migration
  def change
    create_table :moment_statistics do |t|
      t.integer :moment_id
      t.integer :shared_count, :default=>0
      t.integer :played_count, :default=>0
      t.timestamps
    end
  end
end
