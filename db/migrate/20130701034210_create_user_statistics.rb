class CreateUserStatistics < ActiveRecord::Migration
  def change
    create_table :user_statistics do |t|
      t.integer :user_id
      t.integer :create_count, :default=>0
      t.integer :create_played_count, :default=>0
      t.integer :shared_count, :default=>0
      t.integer :shared_played_count, :default=>0
      t.timestamps
    end
  end
end
