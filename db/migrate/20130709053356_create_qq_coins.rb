class CreateQqCoins < ActiveRecord::Migration
  def change
    create_table :qq_coins do |t|
      t.timestamps
    end
  end
end
