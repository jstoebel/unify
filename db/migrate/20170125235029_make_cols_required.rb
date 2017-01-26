class MakeColsRequired < ActiveRecord::Migration[5.0]
  def up
    change_column :bottles, :code, :string, :null => false
    change_table :donations do |t|
      t.change :user_id, :integer, null: false
      t.change :place_id, :integer, null: false
    end

  end

  def down
    change_table :donations do |t|
        t.change :user_id, :integer, null: true
        t.change :place_id, :integer, null: true
    end
    change_column :bottles, :code, :string, null: true

  end
end
