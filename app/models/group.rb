class Group
  include Mongoid::Document

  field :name, type: String
  field :url,  type: String

  mount_uploader :avatar, AvatarUploader
end
