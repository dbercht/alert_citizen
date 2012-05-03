class TaggedImagesController < ApplicationController
	before_filter :authenticate_user!, :only => :create
  def index
		@search = []
		if(params[:emergency] == "on")
			@search << "emergency = true"
		end
		if(params[:user_id])
			@search << "user_id = " + params[:user_id].to_s
		end
		if(params[:liked] == "on" && params[:disliked] == "on")
		elsif(params[:liked] == "on")
			@search << "tagged_images.like = true"
		elsif(params[:disliked] == "on")
			@search << "tagged_images.like = false"
		end
		if(params[:search] && params[:search][:theme_ids])
			@search << "theme_id IN ("+ params[:search][:theme_ids].join(", ") + ")"
		end
		@search << " "
		@search = @search.join(" AND ")
logger.info(@search)
		if(params[:range].nil? || params[:range][:start_date].empty?|| params[:range][:end_date].empty?) 
			@start_date = Date.today - 2.days 
			@end_date = Date.today
		else 
			@date_string = params[:range][:start_date]
			@start_date = Date.civil(@date_string.split('/')[2].to_i,@date_string.split('/')[0].to_i, @date_string.split('/')[1].to_i) 
			@date_string = params[:range][:end_date]
			@end_date = Date.civil(@date_string.split('/')[2].to_i,@date_string.split('/')[0].to_i, @date_string.split('/')[1].to_i) 
		end
		unless(params[:user_tagged] == "on")
			respond_to do |format|
				format.html do
					@json = TaggedImage.in_date_range(@start_date, @end_date, @search).to_gmaps4rails do |image, marker|
					marker.infowindow render_to_string(:partial => "/tagged_images/marker", :locals => { :image => image})
					marker.picture({
								          :picture => "#{image.themeImage}",
								          :width   => 32,
								          :height  => 32
								         })
					marker.title   "#{image.theme}"
					marker.sidebar render_to_string(:partial => "/tagged_images/marker", :locals => { :image => image})
					marker.json({ :id => image.id, :foo => "bar" })
					end
				end
				format.js do
					@json = TaggedImage.in_date_range(@start_date, @end_date, @search)
					render :json => {:tagged_images => @json}
				end
			end
		else
			@json = current_user.tagged_images.in_date_range(@start_date, @end_date, @search).to_gmaps4rails do |image, marker|
				marker.infowindow render_to_string(:partial => "/tagged_images/marker", :locals => { :image => image})
				marker.picture({
						            :picture => "#{image.themeImage}",
						            :width   => 32,
						            :height  => 32
						           })
				marker.title   "#{image.theme}"
				marker.sidebar render_to_string(:partial => "/tagged_images/marker", :locals => { :image => image})
				marker.json({ :id => image.id, :foo => "bar" })
			end
		end
		@themes = Theme.all
  end

	def create
		logger.info(params)
		@image = TaggedImage.create(:latitude => params[:latitude], :longitude => params[:longitude], :theme => params[:theme], :street_slug => params[:street_slug], :emergency => params[:emergency], :theme_id => params[:theme_id], :like => params[:like], :image => params[:image], :user_id => params[:user_id])
		render :json => {status => 200}
		
	end
end
