class FavoritesController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def create
    if favoriter.add(resource)
      redirect_to @resource, notice: 'Added to favorites'
    else
      favoriter.remove(resource)
      redirect_to @resource, notice: 'Failed to add as favorite'
    end    
  end

protected
  def resource
    @resource ||= Link.find(params[:link_id])
  end

  def authenticate_user!
    redirect_to root_url, notice: 'Please log in' unless current_user
  end  
end
