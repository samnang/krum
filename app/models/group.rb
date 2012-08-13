class Group
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Search
  include Mongoid::Timestamps

  field :name,        type: String
  field :url_1,       type: String
  field :url_2,       type: String
  field :email,       type: String
  field :description, type: String

  search_in :name, :description, :tags

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :name, :url_1

  before_validation :clean_empty_tags

  def self.search_for(keyword)
    return self.scoped if keyword.blank?

    search(keyword)
  end

  private

  def clean_empty_tags
    tags.reject!{|t| t.strip.blank? } # jquery-chosen plugin sends an addtional blank
  end
end
