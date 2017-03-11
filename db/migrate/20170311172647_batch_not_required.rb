class BatchNotRequired < ActiveRecord::Migration[5.0]
  # batch ids are not required (forever bottles for example won't have them)
  def up
    change_table :bottles do |t|
        t.change :batch_id, :integer, :null => true
    end
  end

  def down
    change_table :bottles do |t|
        t.change :batch_id, :integer, :null => false
    end
  end
end
