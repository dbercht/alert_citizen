class AddGmapsToTaggedImage < ActiveRecord::Migration
  def change
    add_column :tagged_images, :gmaps, :boolean

  end
end
