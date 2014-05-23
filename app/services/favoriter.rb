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
    favorited.add_fav!
  end

  def remove(favorited)
    return false if can_favorite(favorited)
    favorited.user_favorites.delete(@user)
    favorited.remove_fav!
  end
end
