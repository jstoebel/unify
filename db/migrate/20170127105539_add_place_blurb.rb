class AddPlaceBlurb < ActiveRecord::Migration[5.0]
  def up
      add_column :places, :blurb, :text
  end

  def down
      remove_column :places, :blurb
  end
end
