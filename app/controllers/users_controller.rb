class UsersController < ApplicationController

	def new
		@user = User.new
	end
	
	def show
		@wikis = current_user.wikis
	end
end