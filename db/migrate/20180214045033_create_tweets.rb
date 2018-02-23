class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.belongs_to :user, foreign_key: true
      t.text :tweet, null: false
      t.timestamps
    end
  end
end
