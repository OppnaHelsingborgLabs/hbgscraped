require 'open-uri'

class V1::BaseController < ActionController::Metal
	include ActionController::Rendering
	include ActionController::MimeResponds

	# needed for before_filter	
	include AbstractController::Callbacks   	

	# needed to be able to use _url and _path helpers in rabl templates
	include ActionController::UrlFor
	include Rails.application.routes.url_helpers	

	append_view_path "#{Rails.root}/app/views"

	before_filter :ensure_json

	private

		# Return nothing but JSON to avoid having to debug XML responses
		def ensure_json
			if ((request.headers["HTTP_ACCEPT"].nil? && params[:format].nil?) ||
				(request.headers["HTTP_ACCEPT"].include?("*/*") && params[:format].nil?) ||
				(params[:format].downcase.eql?("json")) ||
				(request.headers["HTTP_ACCEPT"].include?("application/json")))
				@content_type = 'application/json; charset=utf-8'
			else
				# TODO: fix this since it does not work perfectly
				render :nothing => true, :status => 406	and return
			end  			  			
		end

end