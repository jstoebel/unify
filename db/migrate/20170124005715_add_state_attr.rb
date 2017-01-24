class AddStateAttr < ActiveRecord::Migration[5.0]
  def up
    change_table :places do |t|
      t.boolean :state
      t.boolean :active
    end
  end

  def down

    change_table :places do |t|
      t.remove :state
      t.remove :active
    end

  end
end
