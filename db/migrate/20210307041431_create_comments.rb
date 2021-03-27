class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.bigint :user_id
      t.integer :blog_id
      t.text :comment, null: false

      t.timestamps
    end
  end
end
