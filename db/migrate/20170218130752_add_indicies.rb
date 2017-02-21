class AddIndicies < ActiveRecord::Migration[5.0]
  def up
    add_index :donations, :user_id
    add_index :donations, :place_id
  end

  def down
  end
end
