class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :item_id
      t.bigint :order_id
      t.integer :count
      t.integer :tax_included_price

      t.timestamps
    end
  end
end
