class CreateBatches < ActiveRecord::Migration[5.0]
  def up
    create_table :batches do |t|
      t.timestamps
    end

    change_table :bottles do |t|
        t.references :batch, :null => false
    end
  end

  def down
      change_table :bottles do |t|
          t.remove :batch_id
      end

      drop_table :batches

  end
end
