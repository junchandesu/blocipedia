class UsersController < ApplicationController

	def new
		@user = User.new
	end
	
	def show
		@wikis = Wiki.visible_to(current_user)
	end
end