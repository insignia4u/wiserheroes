class Box
  include Mongoid::Document
  field :name, type: String
  field :views, type: Integer, default: 0

  validates_presence_of :name

  belongs_to :user
end
