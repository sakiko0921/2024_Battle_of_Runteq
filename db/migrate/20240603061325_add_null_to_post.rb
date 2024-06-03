class AddNullToPost < ActiveRecord::Migration[7.1]
  def change
    change_column :posts, :transcribed_text, :string, null: false
  end
end
