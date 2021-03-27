class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.bigint :user_id
      t.integer :amount, null: false
      t.integer :shipping_fee, null: false
      t.integer :payment, null: false
      t.string :postal_code, null: false
      t.string :prefectures, null: false
      t.string :city, null: false
      t.string :name, null: false
      t.integer :shipping_status, default: 0, null: false

      t.timestamps
    end
  end
end
