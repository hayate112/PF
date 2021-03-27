class CreateReceivers < ActiveRecord::Migration[5.2]
  def change
    create_table :receivers do |t|
      t.bigint :user_id
      t.string :postal_code, null: false
      t.string :prefectures, null: false
      t.string :city, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
