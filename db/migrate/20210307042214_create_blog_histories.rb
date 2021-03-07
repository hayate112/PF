class CreateBlogHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_histories do |t|

      t.timestamps
    end
  end
end
