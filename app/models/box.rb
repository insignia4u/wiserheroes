class Box
  include Mongoid::Document
  field :name, type: String

  validates_presence_of :name

  belongs_to :user
  has_many :links, dependent: :destroy
end
