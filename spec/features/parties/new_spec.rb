require 'rails_helper'

RSpec.describe 'Viewing Party' do
  describe 'As a visitor' do
    describe "When I visit the new viewing party page" do
      it "I can see a message telling me to login to see this page" do
        @user = User.create!(name: 'Phil', email: 'a@a.com', password: 'a', password_confirmation: 'a')
        visit "/new_party/#{@user.id}/princess_mononoke/134"
  
        expect(page).to have_content("This Page Only Accessible by Authenticated Users. Please Log In.")
        expect(current_path).to eq(root_path)
      end
    end
  end
end

feature 'New viewing party' do
  scenario "User visits a new viewing party page", :vcr do

    @user = User.create!(name: 'Phil', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    @user1 = User.create!(name: 'Jade', email: 'b@a.com', password: 'a', password_confirmation: 'a')
    @user2 = User.create!(name: 'Robert', email: 'c@a.com', password: 'a', password_confirmation: 'a')
    @user3 = User.create!(name: 'Luke', email: 'd@a.com', password: 'a', password_confirmation: 'a')

    Friendship.create!(user_id: @user.id, friend_id: @user1.id)
    Friendship.create!(user_id: @user.id, friend_id: @user2.id)
    Friendship.create!(user_id: @user.id, friend_id: @user3.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit "/new_party/#{@user.id}/princess_mononoke/134"
    expect(page).to have_xpath("//input[@value='Princess Mononoke']")
    expect(page).to have_xpath("//input[@value=134]")
    # expect(page).to have_selector('party_date')
  end
end
