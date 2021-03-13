class CreateBlogHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_histories do |t|
      t.bigint :user_id
      t.integer :blog_id

      t.timestamps
    end
  end
end
