class CreateItemHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :item_histories do |t|
      t.bigint :user_id
      t.integer :item_id

      t.timestamps
    end
  end
end
