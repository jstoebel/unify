class CreatePlaces < ActiveRecord::Migration[5.0]
    def up
        create_table :places do |t|
            t.string :code, null: false
            t.string :name, null: false
            t.timestamps
        end
    end

    def down
        drop_table :places
    end

end
