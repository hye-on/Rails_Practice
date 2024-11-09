class AddFieldsToBannedWord < ActiveRecord::Migration[7.1]
  def change
    add_column :banned_words, :policy, :string
    add_column :banned_words, :exceptions, :text
    add_column :banned_words, :match_target, :string
  end
end
