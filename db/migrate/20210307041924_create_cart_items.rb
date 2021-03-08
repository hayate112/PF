class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.bigint :user_id
      t.integer :item_id
      t.integer :count

      t.timestamps
    end
  end
end
