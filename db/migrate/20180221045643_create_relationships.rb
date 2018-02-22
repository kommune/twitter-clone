class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.references :follower, references: :users, null: false
      t.references :following, references: :users, null: false
      t.timestamps
    end

    add_foreign_key :relationships, :users, column: :follower_id
    add_foreign_key :relationships, :users, column: :following_id
    add_index :relationships, [:follower_id, :following_id], unique: true

  end
end
