class CreateBlogImages < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_images do |t|
      t.integer :blog_id
      t.string :image_id

      t.timestamps
    end
  end
end
