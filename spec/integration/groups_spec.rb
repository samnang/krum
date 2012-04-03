require 'spec_helper'

feature "Viewing groups" do
  background do
    2.times {|i| Factory(:group, name: "Group#{i}") }
  end

  scenario "Listing all groups" do
    visit root_path

    within("#groups") do
      page.has_content?('Group 0')
      page.has_content?('Group 1')
    end
  end
end

feature "Adding a new group" do
  background do
    Factory(:group, :name => "Group1", :tags => ['ruby', 'rails'])
    Factory(:group, :name => "Group2", :tags => ['javascript', 'nodejs'])
    # Duplicate tag names
    Factory(:group, :name => "Group3", :tags => ['javascript', 'ruby'])
  end

  scenario "added successfully" do
    visit root_path
    click_link "Add New Group"

    within("#new_group") do
      fill_in 'Name', :with => 'ShareVision'
      fill_in 'Url', :with => 'http://sharevisionteam.org'
      fill_in 'Email', :with => 'info@sharevisionteam.org'
      select 'ruby', :from => 'Tags'
      select 'rails', :from => 'Tags'
      attach_file 'Avatar', File.join(Rails.root, 'app/assets/images/fallback_group.png')

      click_on "Create Group"
    end

    page.has_content?("Group has been added successfully.")
    page.has_content?('ShareVision')

    latest_group.should have_tag('ruby')
    latest_group.should have_tag('rails')
  end

  def latest_group
    @latest_group ||= Group.last
  end
end
