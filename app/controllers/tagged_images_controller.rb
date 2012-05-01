class TaggedImagesController < ApplicationController
  def index
		@json = TaggedImage.all.to_gmaps4rails do |image, marker|
			marker.infowindow render_to_string(:partial => "/tagged_images/marker", :locals => { :image => image})
			marker.picture({
				              :picture => "#{TaggedImage.themeImage(image.theme)}",
				              :width   => 32,
				              :height  => 32
				             })
			marker.title   "#{image.theme}"
			marker.sidebar render_to_string(:partial => "/tagged_images/marker", :locals => { :image => image})
			marker.json({ :id => image.id, :foo => "bar" })
		end
  end

	def create
		logger.info(params)
		@image = TaggedImage.create(:latitude => params[:latitude], :longitude => params[:longitude], :theme => params[:theme], :street_slug => params[:street_slug], :emergency => params[:emergency], :theme_id => params[:theme_id], :like => params[:like], :image => params[:image], :user_id => params[:user_id])
		render :json => {status => 200}
		
	end
end
