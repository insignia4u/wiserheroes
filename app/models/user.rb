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

  has_and_belongs_to_many :favorited_links, class_name: "Link", inverse_of: :user_favorites

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

  def add_fav!
    update_attributes( :favorites_count => favorites_count + 1)
  end  

  def remove_fav!
    if favorites_count > 0
      update_attributes( :favorites_count => favorites_count - 1)
    else
      update_attributes( :favorites_count => 0)
    end
  end
end
