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
