class Favoriter
  def initialize(user)
    @user = user
  end

  def can_favorite(favorited)
    !favorited.user_favorites.include?(@user)
  end

  def add(favorited)
    return false unless can_favorite(favorited) 
    favorited.user_favorites << @user
    @user.reload
    @user.update_counter_cache
  end

  def remove(favorited)
    favorited.user_favorites.delete(@user)
    @user.reload
    @user.update_counter_cache
  end
end
