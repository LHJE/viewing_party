require 'rails_helper'

RSpec.describe 'Discover Movies' do
  describe 'As a visitor' do
    describe "When I visit the discover page" do
      it "I can see a message telling me to login to see this page" do
        visit '/discover'
        expect(page).to have_content("This Page Only Accessible by Authenticated Users. Please Log In.")
        expect(current_path).to eq(root_path)
      end
    end
  end

  describe 'As an authenticated user' do
    describe "When I visit the discover page" do
      before :each do
        @user_1 = User.create(name: 'Jackie Chan', email: '89@89.com', password: '89', password_confirmation: '89')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
        visit '/discover'
      end

      it "I see a button to discover top 40 movies" do
        expect(page).to have_button('Discover Top 40')
      end

      it "I see a search field with button to search movies by title" do
        expect(page).to have_field('keywords')
        expect(page).to have_button('Search By Movie Title')
      end
    end
  end
end

feature 'Results for top 40 movies' do
  before :each do
    @user_1 = User.create(name: 'Jackie Chan', email: '78@78.com', password: '78', password_confirmation: '78')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit '/discover'
  end

  scenario "User clicks the top 40 button", :vcr do
      click_button('Discover Top 40')
      expect(current_path).to eq('/movies')
      expect(page).to have_content("The Green Mile")
      expect(page).to have_content("Vote Average: 8.5")
      expect(page).to have_content("Pulp Fiction")
      expect(page).to have_content("Vote Average: 8.5")
      expect(page).to have_css('ul', :count => 40)
  end
end
