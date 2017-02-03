class AddUserAvatar < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :avatar, :text
  end

  def down
    remove_column :users, :avatar, :text
  end
end
