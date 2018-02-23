class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      
      t.belongs_to :user, foreign_key: true
      t.belongs_to :tweet, foreign_key: true

      t.text :reply

      t.timestamps
    end

    add_index :replies, [:user_id, :tweet_id]
  end
end
