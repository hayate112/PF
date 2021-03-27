class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.integer :count, null: false
      t.boolean :sale_status, null: false

      t.timestamps
    end
  end
end
