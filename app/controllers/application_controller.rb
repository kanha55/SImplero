class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)
	  groups_path(current_user) # your path
	end
end
