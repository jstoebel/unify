class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.integer :user_id
      t.integer :place_id
      t.timestamps
    end

    add_foreign_key :donations, :users
    add_foreign_key :donations, :places
  end

  def down
    remove_foreign_key :donations, :users
    remove_foreign_key :donations, :places
    drop_table :donations
  end
end
