  class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :image, type: String
  field :oauth_token, type: String
  field :oauth_expires_at, type: Time
  field :favorites_count, type: Integer, default: 0  

  validates_presence_of :name

  has_many :boxes
  has_many :links, inverse_of: :user

  has_and_belongs_to_many :favorited_links, 
    inverse_of: :user_favorites,
    class_name: "Link"
    
  scope :most_favorited, -> { order('favorites_count DESC') }


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider         = auth.provider
      user.uid              = auth.uid
      user.name             = auth.info.name
      user.image            = auth.info.image
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
  end

  def update_counter_cache
    total_favorites = favorited_links.inject(0) { |sum, l| sum = sum + l.favorites_count }
    update_attributes( favorites_count: total_favorites )
  end
end
