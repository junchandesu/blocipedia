class WikisController < ApplicationController

  def index
  	@wikis = Wiki.all
    authorize @wikis
 end

  def new
  	@wiki = Wiki.new
    authorize @wiki
  end

  def create
  	@user = User.find(current_user.id)
  	@wiki = current_user.wikis.build(wiki_params)
    authorize @wiki

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
  	@wiki = Wiki.find(params[:id])
    authorize @wiki
  end


  def update
  	@wiki = Wiki.find(params[:id])
    authorize @wiki
  	if @wiki.update_attributes(wiki_params)
  		flash[:notice] = "Wiki was updated."
  		redirect_to current_user
  	else
  		flash[:error] = "There was an error saving the updated wiki."
  		render :edit
  	end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
