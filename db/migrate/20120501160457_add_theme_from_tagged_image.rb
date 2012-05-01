class AddThemeFromTaggedImage < ActiveRecord::Migration
  def change
    add_column :tagged_images, :theme_id, :integer
    remove_column :tagged_images, :theme

  end
end
