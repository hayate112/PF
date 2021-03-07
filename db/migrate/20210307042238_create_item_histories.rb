class CreateItemHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :item_histories do |t|

      t.timestamps
    end
  end
end
