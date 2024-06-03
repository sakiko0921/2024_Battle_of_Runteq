class AddNullToTextImage < ActiveRecord::Migration[7.1]
  def change
    change_column :text_images, :text_image, :string, null: false
  end
end
