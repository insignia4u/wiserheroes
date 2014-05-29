class LinksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :check_ownership!, only: [:edit, :update, :destroy]
  before_action :add_a_fav!, only: [:favorite]
  before_action :remove_a_fav!, only: [:unfavorite]

  def index
    if current_user
      @links = current_user.links 
    else
      @links = Link.all
    end
  end

  def show
    viewer.visits(current_link)
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def create
    @link = current_user.links.build(link_params)

    if @link.save
      redirect_to @link, notice: 'Link was successfully created.'
    else
      render :new
    end
  end

  def update
    if current_link.update(link_params)
      redirect_to @link, notice: 'Link was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    current_link.destroy
    redirect_to links_url, notice: 'Link was successfully destroyed.'
  end

  private
    def current_link
      @link ||= Link.find(params[:id])
    end
    helper_method :current_link

    def link_params
      params.require(:link).permit(:name, :url, :views, :box_id)
    end

    def viewer
      @viewer = Viewer.new(current_user, cookies)
    end

    def check_ownership!
      unless current_link.user == current_user
        redirect_to root_url, notice: "You're trying to update a box that doesnt belongs to you"
      end
    end

    def authenticate_user!
      redirect_to root_url, notice: 'Please log in' unless current_user
    end
end
