require 'spec_helper'

describe Group do
  it "removes blank tags before saving" do
    group = Factory.build(:group, :tags => ["", "Ruby", " "])

    group.valid?

    group.tags.should == ["Ruby"]
  end
  
  describe "validations" do
    it 'has a valid factory' do
      Factory.build(:group).should be_valid
    end

    it 'is invalid without a name' do
      Factory.build(:group, name: nil).should_not be_valid
    end

    it 'is invalid without primary url' do
      Factory.build(:group, url_1: nil).should_not be_valid
    end
  end

  describe ".search_for" do
    let!(:matched_group_by_name_and_tag) { Factory(:group, name: "My Group Name", tags: ["Ruby"]) }
    let!(:matched_group_by_tag) { Factory(:group, tags: ["Ruby", "Rails"]) }
    let!(:mismatched_group) { Factory(:group) }

    it "returns matched groups by name" do
      results = Group.search_for("My Group")

      results.should == [matched_group_by_name_and_tag]
    end

    it "returns matched groups by tag" do
      results = Group.search_for("Ruby")

      results.should have(2).groups
      results.should_not include mismatched_group
    end
  end
end
