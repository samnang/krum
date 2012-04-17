require 'spec_helper'

feature "Viewing groups" do
  background do
    2.times {|i| Factory(:group, name: "Group #{i}") }
  end

  scenario "Listing all groups" do
    visit root_path

    within("#groups") do
      page.should have_content('Group 0')
      page.should have_content('Group 1')
    end
  end

  scenario "a project has tags" do
    a_group_has_tags = Factory(:group, name: "Tagging Group", tags: ['ruby', 'javascript'])
    visit root_path

    within("#group_#{a_group_has_tags.id}") do
      page.should have_content("ruby")
      page.should have_content("javascript")
    end
  end
end

feature "Adding a new group" do
  background do
    Factory(:group, :name => "Group1", :tags => ['ruby', 'rails'])
    Factory(:group, :name => "Group2", :tags => ['javascript', 'nodejs'])
    Factory(:group, :name => "Group3", :tags => ['javascript', 'ruby'])
  end

  scenario "added successfully" do
    admin_sign_in

    visit root_path

    click_link "Add New Group"

    within("#new_group") do
      fill_in 'Name', :with => 'ShareVisionTeam'
      fill_in 'Url 1', :with => 'http://sharevisionteam.org'
      fill_in 'Email', :with => 'info@sharevisionteam.org'
      fill_in 'Description', :with => 'My description'
      select 'ruby', :from => 'Tags'
      select 'rails', :from => 'Tags'
      attach_file 'Avatar', File.join(Rails.root, 'app/assets/images/fallback_group.png')

      click_on "Create Group"
    end

    page.should have_content("Group has been added successfully.")
    page.should have_content('ShareVisionTeam')

    latest_group.should have_tag('ruby')
    latest_group.should have_tag('rails')
  end

  def latest_group
    @latest_group ||= Group.last
  end
end

feature "Searching groups" do
  background do
    Factory(:group, :name => "Found Group", :tags => ['education', 'ruby', 'rails'])
    Factory(:group, :name => "Group2", :tags => ['javascript', 'nodejs'])
    Factory(:group, :name => "Group3", :tags => ['javascript', 'ruby'])
  end

  scenario "found by name" do
    visit root_path

    search_with("Found Group")

    page.should have_content("Found Group")
    page.should_not have_content("Group2")
    page.should_not have_content("Group3")
  end

  scenario "found by tag" do
    visit root_path

    search_with("education")

    page.should have_content("Found Group")
    page.should_not have_content("Group2")
    page.should_not have_content("Group3")
  end

  def search_with(query)
    fill_in "q", :with => query
    click_on "Search"
  end
end
