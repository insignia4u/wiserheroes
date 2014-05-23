class Link
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
  field :views, type: Integer, default: 0
  field :favorites_count, type: Integer, default: 0

  belongs_to :box
  belongs_to :user, inverse_of: :links
  
  has_and_belongs_to_many :user_favorites, class_name: "User", inverse_of: :favorited_links

  def add_fav!
    update_attributes( :favorites_count => favorites_count + 1 )
  end  

  def remove_fav!
    if favorites_count > 0
      update_attributes( :favorites_count => favorites_count - 1 )
    else
      update_attributes( :favorites_count => 0 )
    end
  end

  def update_views!
    update_attributes(:views => views + 1 )
  end
end
