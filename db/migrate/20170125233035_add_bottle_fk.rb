class AddBottleFk < ActiveRecord::Migration[5.0]
  def up
    change_table :donations do |t|
      t.references :bottle, :null => false
    end
  end

  def down
      change_table :donations do |t|
        t.remove_index :bottle_id
        t.remove :bottle_id
      end
  end
end
