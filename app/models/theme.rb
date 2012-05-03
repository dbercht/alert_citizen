class Theme < ActiveRecord::Base
	def theme_image
		"/images/theme_markers/"+id.to_s+".png"
	end
end
