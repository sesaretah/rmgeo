class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.text :geo_json

      t.timestamps
    end
  end
end
