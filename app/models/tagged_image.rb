class TaggedImage < ActiveRecord::Base
	belongs_to :user
	belongs_to :theme
	acts_as_gmappable
	has_attached_file :image, :styles => {:thumbnail => "64x64#"}, 
:path => ":rails_root/public/images/:id/:style/:filename", :url => "/images/:id/:style/:filename"


	def gmaps4rails_address
	  "#{self.street_slug}" 	
	end

	def themeImage
		"/images/theme_markers/"+id.to_s+".png"
	end

end
