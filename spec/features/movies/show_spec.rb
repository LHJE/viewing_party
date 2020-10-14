require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Movies Show Page' do
  describe 'As a visitor' do
    describe "When I visit the movies show page" do
      it "I can see a message telling me to login to see this page", :vcr do
        visit '/movies/278'
        expect(page).to have_content("This Page Only Accessible by Authenticated Users. Please Log In.")
        expect(current_path).to eq(root_path)
      end
    end
  end
end

feature 'Details for a movie' do
  before :each do
    @user_1 = User.create(name: 'Jackie Chan', email: '56@56.com', password: '56', password_confirmation: '56')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit register_path
  end

  scenario "User visits a movie's page", :vcr do
    visit "/movies/278"

    expect(page).to have_content("The Shawshank Redemption")
    expect(page).to have_content("Vote Average: 8.7")
    expect(page).to have_content("Runtime: 2hrs, 22 minutes")
    expect(page).to have_content("Drama")
    expect(page).to have_content("Crime")

    expect(page).to have_content("Tim Robbins as Andy Dufresne")
    expect(page).to have_content('Morgan Freeman as Ellis Boyd "Red" Redding')
    expect(page).to have_content("Bob Gunton as Warden Samuel Norton")
    expect(page).to have_content("William Sadler as Heywood")
    expect(page).to have_content("Clancy Brown as Captain Byron T. Hadley")
    expect(page).to have_content("Gil Bellows as Tommy")
    expect(page).to have_content("Mark Rolston as Bogs Diamond")
    expect(page).to have_content("James Whitmore as Brooks Hatlen")
    expect(page).to have_content("Jeffrey DeMunn as 1946 D.A.")
    expect(page).to have_content("Larry Brandenburg as Skeet")

    expect(page).to have_content("Reviews: 6")
    expect(page).to have_content("elshaarawy")
    expect(page).to have_content("John Chard")
    expect(page).to have_content("tmdb73913433")
    expect(page).to have_content("thommo_nz")
    expect(page).to have_content("Andrew Gentry")
    expect(page).to have_content("Matthew Dixon")

    expect(page).to have_content("New York Times Review Link:")
    expect(page).to have_content("Prison Tale by Stephen King Told Gently, Believe It or Not")
    expect(page).to have_link("Prison Tale by Stephen King Told Gently, Believe It or Not")

    expect(page).to have_content("Similar Films:")
    expect(page).to have_content("District 13: Ultimatum")
    expect(page).to have_content("Malcolm X")
  end

  scenario "User visits a movie's page that has no nyt review", :vcr do
    visit "/movies/724089"

    expect(page).to have_content("Gabriel's Inferno Part II")
    expect(page).to have_content("The New York Times has not reviewed this film")
  end
end
