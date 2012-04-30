class TaggedImage < ActiveRecord::Base
	belongs_to :user
	acts_as_gmappable
	has_attached_file :image, :styles => {:thumbnail => "64x64#"}, 
:path => ":rails_root/public/images/:user_id/:theme/:id/:style/:filename", :url => "/public/:user_id/:theme/:id/:style/:filename"


	def gmaps4rails_address
	  "#{self.street_slug}" 	
	end

	def self.themeImage(theme)
		"/images/thumbnail/" + theme + "Marker.png"
	end

end
