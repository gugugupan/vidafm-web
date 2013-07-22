class AddColumnToQqCoins < ActiveRecord::Migration
  def change
     add_column :qq_coins, :code, :string
     add_column :qq_coins, :password, :string
     add_column :qq_coins, :coins, :integer 
     add_column :qq_coins, :is_used, :boolean, :default=>false
  end
end
