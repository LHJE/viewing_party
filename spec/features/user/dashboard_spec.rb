require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Dashboard Page' do
  describe 'As a visitor' do
    describe "When I visit the dashboard page" do
      it "I can see a message telling me to login to see this page" do
        visit 'user/dashboard'
        expect(page).to have_content("This Page Only Accessible by Authenticated Users. Please Log In.")
        expect(current_path).to eq(root_path)
      end
    end
  end

  describe 'As an authenticated  user' do
    before :each do
      @user_1 = User.create(name: 'Jackie Chan', email: '67@67.com', password: '67', password_confirmation: '67')
      @user_2 = User.create(name: 'Cynthia Rothrock', email: 'er@b.com', password: 'b', password_confirmation: 'b')
      @user_3 = User.create(name: 'Michelle Yeoh', email: 'er@c.com', password: 'c', password_confirmation: 'c')
      @user_4 = User.create(name: 'Bilbo Baggins', email: 'er@d.com', password: 'd', password_confirmation: 'd')
      @user_5 = User.create(name: 'Gandolf', email: 'er@e.com', password: 'e', password_confirmation: 'e')
      @user_6 = User.create(name: 'Sneezy', email: 'er@f.com', password: 'f', password_confirmation: 'f')
      @user_7 = User.create(name: 'WTF', email: 'er@wtf.com', password: 'wtf', password_confirmation: 'wtf')

      @friendship_1 = Friendship.create(user_id: @user_1.id, friend_id: @user_2.id)
      @friendship_2 = Friendship.create(user_id: @user_2.id, friend_id: @user_1.id)
      @friendship_3 = Friendship.create(user_id: @user_1.id, friend_id: @user_3.id)
      @friendship_4 = Friendship.create(user_id: @user_3.id, friend_id: @user_1.id)
      @friendship_5 = Friendship.create(user_id: @user_1.id, friend_id: @user_4.id)
      @friendship_6 = Friendship.create(user_id: @user_4.id, friend_id: @user_1.id)
      @friendship_7 = Friendship.create(user_id: @user_2.id, friend_id: @user_3.id)
      @friendship_8 = Friendship.create(user_id: @user_3.id, friend_id: @user_2.id)
      @friendship_9 = Friendship.create(user_id: @user_2.id, friend_id: @user_5.id)
      @friendship_10 = Friendship.create(user_id: @user_5.id, friend_id: @user_2.id)

      @party_1 = Party.create(movie_title: "The Exorcist III", user_id: @user_1.id, date: "October 26th, 1997", time: "1:45pm")
      @party_2 = Party.create(movie_title: "Psycho II", user_id: @user_1.id, date: "June 2nd, 1998", time: "2:45pm")
      @party_3 = Party.create(movie_title: "Hellbound: Hellraiser II", user_id: @user_1.id, date: "September 22nd, 1999", time: "3:45pm")
      @party_4 = Party.create(movie_title: "House II: The Second Story", user_id: @user_2.id, date: "April 22nd, 2000", time: "4:45pm")
      @party_5 = Party.create(movie_title: "The Gate II", user_id: @user_2.id, date: "January 19nd, 2001", time: "5:45pm")
      @party_6 = Party.create(movie_title: "Ip Man II", user_id: @user_2.id, date: "July 1nd, 2002", time: "6:45pm")
      @party_7 = Party.create(movie_title: "The Fortress II", user_id: @user_3.id, date: "January 7th, 2003", time: "7:45pm")

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
      @party_user_13 = PartyUser.create(party_id: @party_7.id, user_id: @user_1.id, status: 0)
    end

    it "I can see that I don't have friends if I don't have friends" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_6)
      visit 'user/dashboard'
      expect(page).to have_content("You currently have no friends.")
    end

    it "I can see a personalized welcome message after logging in" do
      visit root_path

      fill_in 'Email', with: @user_1.email
      fill_in 'Password', with: @user_1.password

      click_button "Log In"

      expect(page).to have_content('Welcome, Jackie Chan, you are logged in!')
    end

    describe "If I'm logged in and have friends" do
      before :each do
        visit root_path

        fill_in 'Email', with: @user_1.email
        fill_in 'Password', with: @user_1.password

        click_button "Log In"
      end

      it "I can see a personalized greeting if I navigate away, and navigate back" do
        visit root_path
        visit 'user/dashboard'
        expect(page).to have_content('Welcome Jackie Chan!')
      end

      it "I can see a button to Discover Movies" do
        expect(page).to have_button('Discover Movies')
      end

      it "I am sent to Discover Movies when I click the button" do
        click_button 'Discover Movies'

        expect(current_path).to eq('/discover')
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

      it "I can see a button allowing me to add a friend" do
        expect(page).to have_button("Add Friend")
      end

      it "I can add a new friend if they exist in the system" do
        fill_in "New Friend's Email", with: 'er@wtf.com'

        click_button "Add Friend"

        expect(page).to have_content("WTF")
      end

      it "I can not add a new friend if they don't exist in the system" do
        fill_in "New Friend's Email", with: "z@z.com"

        click_button "Add Friend"

        expect(page).to have_content("Email Address not in our system.")
      end

      it "I can not add a friend I already have" do
        fill_in "New Friend's Email", with: "er@b.com"

        click_button "Add Friend"

        expect(page).to have_content("They're already your friend!")
      end

      it "I can not add myself as a friend" do
        fill_in "New Friend's Email", with: "67@67.com"

        click_button "Add Friend"

        expect(page).to have_content("Well that's your email address! We do like that you're trying to be your own friend though :)")
      end

      it "I can see the viewing parties I'm hosting" do
        hosting_parties = [@party_1, @party_2, @party_3]
        hosting_parties.each do |party|
          within "#party-#{party.id}" do
            expect(page).to have_content("#{party.movie_title}")
            expect(page).to have_content("Date: #{party.date}")
            expect(page).to have_content("Time: #{party.time}")
            expect(page).to have_content("Status: Host")
          end
        end
      end

      it "I can see the viewing parties I'm invited to" do
        invited_to_parties = [@party_4, @party_5, @party_7]
        invited_to_parties.each do |party|
          within "#party-#{party.id}" do
            expect(page).to have_content("#{party.movie_title}",)
            expect(page).to have_content("Date: #{party.date}")
            expect(page).to have_content("Time: #{party.time}")
            expect(page).to have_content("Status: Invited")
          end
        end
      end
    end
  end
end
