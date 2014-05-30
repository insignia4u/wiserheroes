class Box
  include Mongoid::Document
  field :name, type: String
  field :slug, type: String
  field :_id,
    type: String,
    default: ->{ slug }

  validates_uniqueness_of :slug
  validates_presence_of :name
  
  before_create :slug_to_lower

  belongs_to :user
  has_many :links, dependent: :destroy

  protected
    def slug_to_lower
      self.slug.downcase!
    end
end
