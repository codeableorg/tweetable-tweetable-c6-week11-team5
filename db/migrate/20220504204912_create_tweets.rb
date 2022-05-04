class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.text :body, length: 140
      t.integer :replies_count, default: 0
      t.integer :likes_count, default: 0
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
