class CreateBottles < ActiveRecord::Migration[5.0]
  def up
    create_table :bottles do |t|
      t.string :code
      t.timestamps
    end
  end

  def down
    drop_table :bottles
  end
end
