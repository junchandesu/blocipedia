class UsersController < ApplicationController

	def set_user
  		# @user = User.find(params[:id])
  		@user = User.friendly.find(params[:id])
	end

	def new
		@user = User.new
	end
	
	def show
		@wikis = Wiki.visible_to(current_user)
        #@wikis = policy_scope(Wiki)
    end
end