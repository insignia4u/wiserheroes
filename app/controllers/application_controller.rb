class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  expose(:by_user_favorites) { User.most_favorited }
  expose(:favoriter) { Favoriter.new(current_user) }
  expose(:by_views) { Link.most_visited.top_ranked }
  expose(:by_favorites) { Link.most_favorited.top_ranked }

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def updates_rank
    @rank = User.all
    @rank.each do |refresh|
      refresh.update_counter_cache
    end
  end
  helper_method :updates_rank
end
