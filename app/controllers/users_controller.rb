class UsersController < ApplicationController

	def new
		@user = User.new
	end
	
	def show
		@wikis = current_user.wikis.visible_to
	end
end