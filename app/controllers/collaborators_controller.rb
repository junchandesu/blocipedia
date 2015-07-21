class CollaboratorsController < ApplicationController
  def create
  	@user = User.find(params[:user_id])
  	@wiki = Wiki.find(params[:wiki_id])
  	@collaborator = Collaborator.create(wiki: @wiki, user: @user)
  	if @collaborator.save
  		flash[:notice] = "Collaborator added"
  	else
  		flash[:error] = "There was a problem adding a collaborator."
  	end
  
  end

  def destroy
  	@user = User.find(params[:user_id])
  	@wiki = Wiki.find(params[:wiki_id])
  	@collaborator = Collaborator.where(user_id: @user, wiki_id: @wiki)
  	if @collaborator.destroy
  		flash[:notice] = "Collaborator removed"
  	else
  		flash[:error] = "There was an error. Pleaset try again"
  	end
  	redirect_to edit_wiki_path(@wiki) 
  end
end
