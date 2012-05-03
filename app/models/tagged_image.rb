class TaggedImage < ActiveRecord::Base
	belongs_to :user
	belongs_to :theme
	acts_as_gmappable
	has_attached_file :image, :styles => {:thumbnail => "64x64#"}, 
:path => ":rails_root/public/images/:id/:style/:filename", :url => "/images/:id/:style/:filename"

	scope :in_date_range, lambda { |start_date, end_date, search|
		where(search + " created_at between ? and ?", start_date, end_date).order("created_at DESC").includes('theme')
	}

	def gmaps4rails_address
	  "#{self.street_slug}" 	
	end

	def themeImage
		theme.theme_image
	end

end
