require 'spec_helper'

feature "Submiting a new group", :js => true do
  scenario "valid information" do
    visit root_path

    page.find(".submit-new-group").click

    sleep(0.5)

    within("#new-group-modal") do
      fill_in 'Name', with: 'My New Group'
      fill_in 'Url', with: 'http://domain.org'
      fill_in 'Email', with: 'info@domain.org'

      find_button("Submit").trigger('click')
      click_on "Submit"
    end

    page.should have_content("The group will be moderated, and hopefully it will be added to site soon.")
    ActionMailer::Base.deliveries.count.should == 1
  end
end

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
    a_group_has_tags = Factory(:group, tags: ['ruby', 'javascript'])
    visit root_path

    within("#group_#{a_group_has_tags.id}") do
      page.should have_content("ruby")
      page.should have_content("javascript")
    end
  end
end

feature "Searching groups" do
  background do
    Factory(:group, name: "Found Group", tags: ['education', 'ruby', 'rails'])
    Factory(:group, name: "Foo", tags: ['javascript', 'nodejs'])
    Factory(:group, name: "Bar", tags: ['javascript', 'ruby'])
  end

  scenario "found by name" do
    visit root_path

    search_with("Found Group")

    page.should have_content("Found Group")
    page.should_not have_content("Foo")
    page.should_not have_content("Bar")
  end

  scenario "found by tag" do
    visit root_path

    search_with("education")

    page.should have_content("Found Group")
    page.should_not have_content("Foo")
    page.should_not have_content("Bar")
  end

  def search_with(query)
    fill_in "q", with: query
    click_on "Search"
  end
end

feature "Adding a new group" do
  background do
    Factory(:group, tags: ['ruby', 'rails'])
    Factory(:group, tags: ['javascript', 'ruby'])
  end

  scenario "added successfully" do
    admin_sign_in

    visit root_path

    click_link "Add New Group"

    within("#new_group") do
      fill_in 'Name', with: 'My New Group'
      fill_in 'Url 1', with: 'http://domain.org'
      fill_in 'Email', with: 'info@domain.org'
      fill_in 'Description', with: 'My Description'
      select 'ruby', from: 'Tags'
      select 'rails', from: 'Tags'
      attach_file 'Avatar', File.join(Rails.root, 'app/assets/images/fallback_group.png')

      click_on "Create Group"
    end

    page.should have_content("Group has been added successfully.")

    latest_group.name.should == 'My New Group'
    latest_group.tags.should == %w(ruby rails)
  end

  def latest_group
    @latest_group ||= Group.last
  end
end

feature "Deleting a group" do
  scenario "deleted successfully" do
    to_be_deleted_group = Factory(:group, name: "Foo")

    admin_sign_in

    visit root_path

    within("#group_#{to_be_deleted_group.id}") do
      click_link "Delete Group"
    end

    page.should have_content("Group has been deleted successfully.")
    page.should_not have_content("Foo")
  end
end

feature "Editing a group" do
  scenario "updated successfully" do
    group = Factory(:group, name: "Foo")

    admin_sign_in

    visit root_path

    within("#group_#{group.id}") do
      click_link "Edit Group"
    end

    within ".edit_group" do
      fill_in "Name", with: "Bar"
    end

    click_on "Update Group"

    page.should have_content("Group has been updated successfully.")
    page.should have_content("Bar")
    page.should_not have_content("Foo")
  end
end
