class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.integer :follower_id, null: false
      t.integer :followee_id, null: false

      t.timestamps
      t.timestamp :deleted_at
    end

    add_index :follows, [:follower_id, :followee_id], unique: true
    add_foreign_key :follows, :users, column: :follower_id
    add_foreign_key :follows, :users, column: :followee_id
  end
end
