class WikisController < ApplicationController

  def index
  	# @wikis = Wiki.all
    @wikis = policy_scope(Wiki)
    #authorize @wikis
 end

  def new
  	@wiki = Wiki.new
    authorize @wiki
  end

  def create
    @user = current_user
   	@wiki = Wiki.new(wiki_params)
    @wiki.user_id = @user.id
    authorize @wiki

  	if @wiki.save
  		flash[:notice] = "New Wiki is saved."
  		redirect_to @wiki
  	else
  		 flash[:error] = "There was an error saving this new wiki."
  		 render :new
  	end
  end


  def show
    @wiki = Wiki.find(params[:id])
    @user = User.all
    authorize @wiki
  end

  def edit
  	@wiki = Wiki.find(params[:id])
    @users = collaborators_list 
    authorize @wiki
  end


  def update
  	@wiki = Wiki.find(params[:id])
    authorize @wiki
  	if @wiki.update_attributes(wiki_params)
  		flash[:notice] = "Wiki was updated."
  		render :show
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
      redirect_to wikis_path
    else
      flash[:error] = "Wiki was not deleted successfully."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
 
  def collaborators_list  
    collabos = []
    User.all.each do |user|
      if !user.admin? || user != current_user
        collabos << user
      end 
     end
     collabos
   end
end
