class UsersController < ApplicationController

	def new
		@user = User.new
	end
	
	def show
		@wikis = Wiki.get_public_wikis
	end
end