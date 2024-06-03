class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :author
      t.string :book
      t.string :description
      t.string :transcribed_text

      t.timestamps
    end
  end
end
