require 'rails_helper'

RSpec.feature "Users", type: :system do
  fixtures :users

  background do
    @user = users(:one)
  end

  scenario "visiting the index" do
    visit users_url
    expect(page).to have_selector "h1", text: "Users"
  end

  scenario "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Name", with: @user.name
    click_on "Create User"

    expect(page).to have_content "User was successfully created"
    click_on "Back"
  end

  scenario "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Name", with: @user.name
    click_on "Update User"

    expect(page).to have_content "User was successfully updated"
    click_on "Back"
  end

  scenario "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    expect(page).to have_content "User was successfully destroyed"
  end
end
