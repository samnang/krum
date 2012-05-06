# Basic tagging system for mongoid documents.
# jpemberthy 2010
#
#  class User
#    include Mongoid::Document
#    include Mongoid::Document::Taggable
#  end
#
#  @user = User.new(:name => "Bobby")
#  @user.tag_list = "awesome, slick, hefty"
#  @user.tags     # => ["awesome","slick","hefty"]
#  @user.save
#
#  User.tagged_with("awesome") # => @user
#  User.tagged_with(["slick", "hefty"]) # => @user
#
#  @user2 = User.new(:name => "Bubba")
#  @user2.tag_list = "slick"
#  @user2.save
#
#  User.tagged_with("slick") # => [@user, @user2]

module Mongoid
  module Document
    module Taggable
      extend ActiveSupport::Concern

      included do
        field :tags, :type => Array
      end

      def tag_list=(tags)
        self.tags = tags.split(",").collect{ |t| t.strip }.delete_if{ |t| t.blank? }
      end

      def tag_list
        self.tags.join(", ") if tags
      end

      def has_tag?(tag_name)
        tags.include?(tag_name.to_s)
      end

      module ClassMethods
        # let's return only :tags
        def tags
          all.only(:tags).collect{ |ms| ms.tags }.flatten.uniq.compact
        end

        def tagged_like(_perm)
          _tags = tags
          _tags.delete_if { |t| !t.include?(_perm) }
        end

        def tagged_with(_tags)
          _tags = [_tags] unless _tags.is_a? Array
          criteria.in(:tags => _tags).to_a
        end
      end

    end
  end
end
