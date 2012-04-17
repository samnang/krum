class Group
  include Mongoid::Document
  include Mongoid::Document::Taggable

  field :name,        type: String
  field :url_1,       type: String
  field :url_2,       type: String
  field :email,       type: String
  field :description, type: String

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :name, :url_1
end
