class FavoritesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    if favoriter.add(resource)
      redirect_to @resource, notice: 'Added to favorites'
    end    
  end

  def destroy
    favoriter.remove(resource)
    redirect_to @resource, notice: 'Removed from favorites'
  end

protected
  def resource
    @resource ||= Link.find(params[:link_id])
  end

  def authenticate_user!
    redirect_to root_url, notice: 'Please log in' unless current_user
  end  
end
