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

  before_validation :clean_empty_tags

  def self.search_for(keyword)
    return self.random if keyword.blank?

    query = /#{keyword}/i
    any_of({name: query}, {tags: query})
  end

  # NOTE: it's probably slow, or check other solutions
  # http://stackoverflow.com/questions/7759250/mongoid-random-document
  def self.random
    all.shuffle
  end

  private

  def clean_empty_tags
    tags.reject!{|t| t.strip.blank? } # jquery-chosen plugin sends an addtional blank
  end
end
