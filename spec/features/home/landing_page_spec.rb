require "spec_helper"

feature "Landing Page" do
  scenario "presenting home page" do
    visit "/"

    expect(page).to have_content("Welcome")
  end
end
