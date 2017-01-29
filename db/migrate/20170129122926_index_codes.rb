class IndexCodes < ActiveRecord::Migration[5.0]
  def up
      add_index :bottles, :code, :unique => true
      add_index :places, :code, :unique => true
  end

  def down
      remove_index :bottles, :code
      remove_index :places, :code
  end
end
