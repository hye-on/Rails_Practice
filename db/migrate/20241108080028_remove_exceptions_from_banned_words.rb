class RemoveExceptionsFromBannedWords < ActiveRecord::Migration[7.1]
  def change
    remove_column :banned_words, :exceptions, :text
  end
end
