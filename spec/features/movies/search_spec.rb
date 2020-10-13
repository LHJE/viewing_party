require 'rails_helper'
RSpec.describe 'Search Movies' do
  describe 'As a visitor' do
    describe "When I visit the search page" do
      it "I can see a message telling me to login to see this page", :vcr do
        visit '/movies'
        expect(page).to have_content("This Page Only Accessible by Authenticated Users. Please Log In.")
        expect(current_path).to eq(root_path)
      end
    end
  end
end

feature 'Searching by movie title' do
  before :each do
    @user_1 = User.create(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit '/discover'
  end

  scenario "User searches using keywords", :vcr do

    fill_in 'Keywords', with: 'whatever'
    click_button('Search By Movie Title')

    expect(current_path).to eq('/movies')
    expect(page).to have_content("Whatever Works")
    expect(page).to have_content("Vote Average: 7.1")
    expect(page).to have_content("Whatever it Takes")
    expect(page).to have_content("Vote Average: 6.5")
    expect(page).to have_css('ul', :count => 40)

    click_link("Whatever Works")
    expect(current_path).to eq('/movies/19265')
  end
end

feature 'Empty search results in top 40' do
  before :each do
    @user_1 = User.create(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit '/discover'
  end

  scenario "User searches with empty field", :vcr do
    click_button('Search By Movie Title')
    expect(current_path).to eq('/movies')

    expect(current_path).to eq('/movies')
    expect(page).to have_content("The Green Mile")
    expect(page).to have_content("Vote Average: 8.5")
    expect(page).to have_content("Pulp Fiction")
    expect(page).to have_content("Vote Average: 8.5")
  end
end
