class CreateCommentLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_likes do |t|
      t.bigint :user_id
      t.bigint :comment_id

      t.timestamps
    end
  end
end
