class WikisController < ApplicationController
  before_action :authorize_user, except: [:index, :show, :new, :create]
  # before_action :user_is_able_to_edit, only: [:edit]

  def show
    @wiki = Wiki.find(params[:id])
  end

  def index
    @wiki = Wiki.all
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.create(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki has been saved"
      redirect_to wikis_path
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was updated"
      redirect_to wikis_path
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "Wiki was deleted successfully"
      redirect_to wikis_path
    else
      flash[:alert] = "There was an error deleting the wiki"
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def authorize_user
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that!"
      redirect_to wiki_path
    end
  end

  # def user_is_able_to_edit
  #   unless current_user || current_user.admin?
  #     flash[:alert] = "You can't do that!!"
  #   end
  # end



end