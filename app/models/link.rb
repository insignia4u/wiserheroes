class Link
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
  field :views, type: Integer, default: 0

  belongs_to :box
  belongs_to :user
end
