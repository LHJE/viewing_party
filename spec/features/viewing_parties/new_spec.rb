require 'rails_helper'

feature 'New viewing party' do
  scenario "User visits a new viewing party page", :vcr do
    @user = User.create!(name: 'Phil', email: 'x@x.com', password: 'x', password_confirmation: 'x')
    @user1 = User.create!(name: 'Jade', email: 'b@a.com', password: 'a', password_confirmation: 'a')
    @user2 = User.create!(name: 'Robert', email: 'c@a.com', password: 'a', password_confirmation: 'a')
    @user3 = User.create!(name: 'Luke', email: 'd@a.com', password: 'a', password_confirmation: 'a')

    Friendship.create!(user_id: @user.id, friend_id: @user1.id)
    Friendship.create!(user_id: @user.id, friend_id: @user2.id)
    Friendship.create!(user_id: @user.id, friend_id: @user3.id)

    party2 = @user1.parties.create!(movie_title: 'Spirited Away', date: '10/31/2020', time: '05:00 PM')
    party2.party_users.create!(party_id: party2.id, user_id: @user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit "/new_party/#{@user.id}/princess_mononoke/134"
    expect(page).to have_field('movie_title', with: 'Princess Mononoke')
    expect(page).to have_field('party_duration', with: '134')
    expect(page).to have_field('party_date')
    fill_in 'party_date', with: "10/31/2020"
    expect(page).to have_field('start_time')
    fill_in 'start_time', with: "05:00 PM"
    expect(page).to have_css("#invitees_#{@user1.id}")
    check("invitees_#{@user1.id}", allow_label_click: true)
    check("invitees_#{@user2.id}", allow_label_click: true)
    click_button 'Create Party'
    expect(current_path).to eq('/user/dashboard')
  end
end
