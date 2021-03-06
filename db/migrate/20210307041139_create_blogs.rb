class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.integer :genre_id

      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
