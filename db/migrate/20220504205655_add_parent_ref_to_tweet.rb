class AddParentRefToTweet < ActiveRecord::Migration[7.0]
  def change
    add_reference :tweets, :replied_to, null: true, foreign_key: {to_table: :tweets}
  end
end
