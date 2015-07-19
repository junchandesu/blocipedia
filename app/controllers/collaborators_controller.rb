class CollaboratorsController < ApplicationController
  def create
  	@user = User.find(params[:user_id])
  	@wiki = Wiki.find(params[:wiki_id])
  	@collaborator = Collaborator.new(wiki_id: @wiki, user_id: @user)
  	if @collaborator.save
  		flash[:notice] = "Collaborator added"
  	else
  		flash[:error] = "There was a problem adding a collaborator."
  	end
   redirect_to edit_user_wiki_path(user_id: current_user, wiki_id: @wiki)
  end

  def destroy
  	@wiki = Wiki.find(params[:wiki_id])
  	@collaborator = Collaborator.find(params[:user_id])
  	if @collaborator.destroy
  		flash[:notice] = "Collaborator removed"
  	else
  		flash[:error] = "There was an error. Pleaset try again"
  	end
  	redirect_to edit_wiki_path(@wiki) 
  end
end
