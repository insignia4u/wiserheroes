class BoxesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership!, only: [:edit, :update, :destroy]

  def index
    @boxes = current_user.boxes
    render :index
  end

  def show
      current_box.views += 1
      current_box.save
  end

  def new
    @box = Box.new
  end

  def edit
  end

  def create
    @box = current_user.boxes.build(box_params)
    if @box.save
      redirect_to @box, notice: 'Box was successfully created.'
    else
      render :new
    end
  end

  def update
    if current_box.update(box_params)
      redirect_to @box, notice: 'Box was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
      current_box.destroy
      redirect_to boxes_url, notice: 'Box was successfully destroyed.'
  end

  private
    def current_box
      @box ||= current_user.boxes.find(params[:id])
    end
    helper_method :current_box

    def box_params
      params.require(:box).permit(:name)
    end

    def check_ownership!
      unless current_box.user == current_user
        redirect_to root_url, notice: "You're trying to update a box that doesnt belongs to you"
      end
    end

    def authenticate_user!
      redirect_to root_url, notice: 'Please log in' unless current_user
    end
end
