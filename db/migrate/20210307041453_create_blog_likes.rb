class CreateBlogLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_likes do |t|

      t.timestamps
    end
  end
end
