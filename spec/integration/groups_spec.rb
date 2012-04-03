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
  scenario "added successfully" do
    visit root_path
    click_link "Add New Group"

    within("#new_group") do
      fill_in 'Name', :with => 'ShareVision'
      fill_in 'Url', :with => 'http://sharevisionteam.org'
      fill_in 'Email', :with => 'info@sharevisionteam.org'
      attach_file 'Avatar', File.join(Rails.root, 'app/assets/images/fallback_group.png')
      
      click_on "Create Group"
    end

    page.has_content?("Group has been added successfully.")
    page.has_content?('ShareVision')
  end
end
