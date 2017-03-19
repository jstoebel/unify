class DonationAddStore < ActiveRecord::Migration[5.0]
  def up
    add_column :donations, :store, :string
  end

  def down
    remove_column :donations, :store
  end
end
