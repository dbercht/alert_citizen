class CreateTaggedImages < ActiveRecord::Migration
  def change
    create_table :tagged_images do |t|
      t.float :latitude
      t.float :longitude
      t.string :street_slug
      t.boolean :emergency
      t.string :theme
      t.boolean :like
      t.integer :user_id

      t.timestamps
    end
  end
end
