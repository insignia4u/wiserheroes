class BoxesController < ApplicationController
  before_action :set_box, only: [:show, :edit, :update, :destroy]

  def index
    @boxes = Box.where(user_id: current_user)
  end

  def show
    @user = User.find(@box.user_id)
    @links = Link.where(box_id: @box.id)
    @box.views += 1
    @box.save
  end

  def new
    if current_user
      @box = Box.new
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
    @box = Box.new(box_params)
    @box.user_id = current_user.id

    if @box.save && user_match
      redirect_to @box, notice: 'Box was successfully created.'
    else
      render :new
    end
  end

  def update
    if @box.update(box_params) && user_match
      redirect_to @box, notice: 'Box was successfully updated.'
    else
      redirect_to root_url, notice: 'Please log in'
    end
  end

  def destroy
    if user_match
      @box.destroy
      redirect_to boxes_url, notice: 'Box was successfully destroyed.'
    else
      redirect_to root_url, notice: 'Please log in'
    end
  end

  private
    def set_box
      @box = Box.find(params[:id])
    end

    def box_params
      params.require(:box).permit(:name)
    end

    def user_match
      if current_user == nil
        false
      else
        @box.user_id == current_user.id
      end
    end
end
