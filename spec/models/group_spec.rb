require 'spec_helper'

describe Group do

  describe "validations" do
    it 'has a valid factory' do
      Factory.build(:group).should be_valid
    end

    it 'is invalid without a name' do
      Factory.build(:group, name: nil).should_not be_valid
    end

    it 'is invalid without an url' do
      Factory.build(:group, url: nil).should_not be_valid
    end
  end
end
