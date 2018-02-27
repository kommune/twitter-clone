class CreateHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :hashtags do |t|
      t.string :hashtag, null: false, index: { unique: true }
      t.timestamps
    end
  end
end

