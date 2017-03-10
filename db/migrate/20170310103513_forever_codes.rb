class ForeverCodes < ActiveRecord::Migration[5.0]
  def up
    add_column :bottles, :forever, :boolean
  end

  def down
    remove_column :bottles, :forever, :boolean
  end
end
