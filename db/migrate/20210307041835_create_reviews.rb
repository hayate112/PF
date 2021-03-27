class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.bigint :user_id
      t.integer :item_id
      t.string :title, null: false
      t.text :body, null: false
      t.float :rate

      t.timestamps
    end
  end
end
