class CreateReceivers < ActiveRecord::Migration[5.2]
  def change
    create_table :receivers do |t|
      t.string :postal_code
      t.string :prefectures
      t.string :city
      t.string :name

      t.timestamps
    end
  end
end
