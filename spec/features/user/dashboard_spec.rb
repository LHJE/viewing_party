require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Dashboard Page' do
  describe 'As a user' do
    before :each do
      @user_1 = User.create(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
      @user_2 = User.create(name: 'Cynthia Rothrock', email: 'b@b.com', password: 'b', password_confirmation: 'b')
      @user_3 = User.create(name: 'Michelle Yeoh', email: 'c@c.com', password: 'c', password_confirmation: 'c')
      @user_4 = User.create(name: 'Bilbo Baggins', email: 'd@d.com', password: 'd', password_confirmation: 'd')
      @user_5 = User.create(name: 'Gandolf', email: 'e@e.com', password: 'e', password_confirmation: 'e')

      @friendship_1 = Friendship.create(user_id: @user_1.id, friend_id: @user_2.id)
      @friendship_2 = Friendship.create(user_id: @user_1.id, friend_id: @user_3.id)
      @friendship_3 = Friendship.create(user_id: @user_4.id, friend_id: @user_1.id)
      @friendship_4 = Friendship.create(user_id: @user_2.id, friend_id: @user_5.id)
      @friendship_5 = Friendship.create(user_id: @user_2.id, friend_id: @user_3.id)

      @party_1 = Party.create(movie_title: "The Exorcist III", user_id: @user_1.id, date: "October 26th, 1997", time: "12:45pm")
      @party_2 = Party.create(movie_title: "Psycho II", user_id: @user_1.id, date: "June 2nd, 1998", time: "12:45pm")
      @party_3 = Party.create(movie_title: "Hellbound: Hellraiser II", user_id: @user_1.id, date: "September 22nd, 1999", time: "12:45pm")
      @party_4 = Party.create(movie_title: "House II: The Second Story", user_id: @user_2.id, date: "April 22nd, 2000", time: "12:45pm")
      @party_5 = Party.create(movie_title: "The Gate II", user_id: @user_2.id, date: "January 19nd, 2001", time: "12:45pm")
      @party_6 = Party.create(movie_title: "Ip Man II", user_id: @user_2.id, date: "July 1nd, 2002", time: "12:45pm")

      @party_user_1 = PartyUser.create(party_id: @party_1.id, user_id: @user_2.id, status: 2)
      @party_user_2 = PartyUser.create(party_id: @party_1.id, user_id: @user_3.id, status: 2)
      @party_user_3 = PartyUser.create(party_id: @party_2.id, user_id: @user_2.id, status: 2)
      @party_user_4 = PartyUser.create(party_id: @party_2.id, user_id: @user_4.id, status: 0)
      @party_user_5 = PartyUser.create(party_id: @party_3.id, user_id: @user_3.id, status: 1)
      @party_user_6 = PartyUser.create(party_id: @party_3.id, user_id: @user_4.id, status: 0)
      @party_user_7 = PartyUser.create(party_id: @party_4.id, user_id: @user_1.id, status: 1)
      @party_user_8 = PartyUser.create(party_id: @party_4.id, user_id: @user_3.id, status: 0)
      @party_user_9 = PartyUser.create(party_id: @party_5.id, user_id: @user_1.id, status: 2)
      @party_user_10 = PartyUser.create(party_id: @party_5.id, user_id: @user_5.id, status: 2)
      @party_user_11 = PartyUser.create(party_id: @party_6.id, user_id: @user_2.id, status: 2)
      @party_user_12 = PartyUser.create(party_id: @party_6.id, user_id: @user_5.id, status: 2)

      visit root_path

      fill_in 'Email', with: @user_1.email
      fill_in 'Password', with: @user_1.password

      click_button "Log In"
    end

    it "I can see a personalized welcome message after logging in" do
      expect(page).to have_content('Welcome, Jackie Chan, you are logged in!')
    end

    it "I can see a personalized greeting if I navigate away, and navigate back" do
      visit root_path
      visit 'user/dashboard'

      expect(page).to have_content('Welcome Jackie Chan!')
    end

    it "I can see a button to Discover Movies" do
      expect(page).to have_button('Discover Movies')
    end

    it "I can see a section showing my friends" do
      expect(page).to have_content("Friends:")
      expect(page).to have_content("Cynthia Rothrock")
      expect(page).to have_content("Michelle Yeoh")
      expect(page).to have_content("Bilbo Baggins")
      expect(page).to_not have_content("Gandolf")
    end

    it "I can see a section showing my viewing parties" do
      expect(page).to have_content("Viewing Parties:")
      expect(page).to have_content("The Exorcist III")
      expect(page).to have_content("Psycho II")
      expect(page).to have_content("House II: The Second Story")
      expect(page).to have_content("The Gate II")
      expect(page).to_not have_content("Ip Man II")
    end
  end
end