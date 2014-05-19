class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = Link.where(user_id: current_user)
  end

  def show
    if current_user
      @box = Box.find(@link.box_id)
      @user = User.find(current_user.id)
      @link.views += 1
      @link.save
    else
      redirect_to root_url, notice: 'Please log in'
    end      
  end

  def new
    if current_user
      @link = Link.new
    else
      redirect_to root_url, notice: 'Please log in'
    end
  end

  def edit
    if current_user
    else
      redirect_to root_url, notice: 'Please log in'
    end
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id

    if @link.save && user_match
      redirect_to @link, notice: 'Link was successfully created.'
    else
      render :new
    end
  end

  def update
    if @link.update(link_params) && user_match
      redirect_to @link, notice: 'Link was successfully updated.'
    else
      redirect_to root_url, notice: 'Please log in'
    end
  end

  def destroy
    if user_match 
      @link.destroy
      redirect_to links_url, notice: 'Link was successfully destroyed.'
    else
      redirect_to root_url, notice: 'Please log in'      
    end
  end

  private
    def set_link
      @link = Link.find(params[:id])
    end

    def link_params
      params.require(:link).permit(:name, :url, :views, :box_id)
    end

    def user_match
      if current_user == nil
        false
      else
        @link.user_id == current_user.id
      end
    end
end
