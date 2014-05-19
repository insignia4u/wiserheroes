class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership!, only: [:edit, :update, :destroy]

  def index
    @links = current_user.links
  end

  def show
      current_link.views += 1
      current_link.save   
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
      @link ||= current_user.links.find(params[:id])
    end
    helper_method :current_link

    def link_params
      params.require(:link).permit(:name, :url, :views, :box_id)
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
