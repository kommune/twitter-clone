class CreateHashtagstweets < ActiveRecord::Migration[5.1]
  def change
    create_table :hashtagstweets do |t|
      t.references :tweet, foreign_key: true
      t.references :hashtag, foreign_key: true
      t.timestamps
    end

    add_index :hashtagstweets, [:tweet_id, :hashtag_id], unique: true

  end
end