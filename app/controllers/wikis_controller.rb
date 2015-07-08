class WikisController < ApplicationController

  def index
  	@wikis = Wiki.visible_to(current_user)
 end

  def new
  	@wiki = Wiki.new
  end

  def create
  	@user = User.find(current_user.id)
  	@wiki = current_user.wikis.build(wiki_params)

  	if @wiki.save
  		flash[:notice] = "New Wiki is saved."
  		redirect_to @user
  	else
  		 flash[:error] = "There was an error saving this new wiki."
  		 redirect_to @user
  	end
  end


  def show

  end

  def edit
  	@wiki = current_user.wikis.find(params[:id])
  end


  def update
  	@wiki = current_user.wikis.find(params[:id])
  	if @wiki.update_attributes(wiki_params)
  		flash[:notice] = "Wiki was updated."
  		redirect_to current_user
  	else
  		flash[:error] = "There was an error saving the updated wiki."
  		render :edit
  	end
  end

  def destroy
    @wiki = current_user.wikis.find(params[:id])
    if @wiki.delete
      flash[:notice] = "Selected Wiki was deleted."
      redirect_to current_user
    else
        flash[:error] = "Wiki was not deleted successfully."
        render :show
    end


  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
 
end
