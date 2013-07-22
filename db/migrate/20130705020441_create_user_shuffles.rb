class CreateUserShuffles < ActiveRecord::Migration
  def change
    create_table :user_shuffles do |t|
      t.integer :user_id
      t.timestamps
    end
   
    add_index :user_shuffles, :user_id
  end
end
