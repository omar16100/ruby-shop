class AdminController < ApplicationController

	authorize_resource
	layout "backend"

	def index
	end
end
