class UsersController < ApplicationController

	def new
		@user = User.new
	end
	
	def show
		@wikis = Wiki.visible_to(current_user)
        #@wikis = policy_scope(Wiki)
    end
end