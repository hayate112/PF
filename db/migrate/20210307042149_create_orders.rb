class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.bigint :user_id
      t.integer :amount
      t.integer :shipping_fee
      t.integer :peyment
      t.integer :shipping_status

      t.timestamps
    end
  end
end
