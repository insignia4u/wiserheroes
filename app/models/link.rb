class Link
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
  field :views, type: Integer, default: 0
  field :favorites_count, type: Integer, default: 0

  belongs_to :box
  belongs_to :user, inverse_of: :links
  
  has_and_belongs_to_many :user_favorites,
    class_name:   "User",
    inverse_of:   :favorited_links,
    after_add:    :increase_favorite_counter, 
    after_remove: :decrease_favorite_counter
  
  validates_presence_of :name
  validates_presence_of :box_id
  
  validates_format_of :url, :with => /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\Z/i, :on => :create

  scope :most_visited,   -> { order('views DESC') }
  scope :most_favorited, -> { order('favorites_count DESC') }
  scope :top_ranked,     -> { limit(5) }

  def increase_favorite_counter(link)!
    update_attributes( :favorites_count => favorites_count + 1 )
  end  

  def decrease_favorite_counter(link)!
      update_attributes( :favorites_count => favorites_count - 1 )
  end
  
  def update_views!
    update_attributes(:views => views + 1 )
  end
end
