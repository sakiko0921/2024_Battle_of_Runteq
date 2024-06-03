class CreateTextImages < ActiveRecord::Migration[7.1]
  def change
    create_table :text_images do |t|
      t.references :post, null: false, foreign_key: true
      t.string :text_image

      t.timestamps
    end
  end
end
