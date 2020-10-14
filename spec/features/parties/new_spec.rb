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
  describe "As a logged in user" do
      before :each do
        @user = User.create!(name: 'Phil', email: 'a@a.com', password: 'a', password_confirmation: 'a')
        @user1 = User.create!(name: 'Jade', email: 'b@a.com', password: 'a', password_confirmation: 'a')
        @user2 = User.create!(name: 'Robert', email: 'c@a.com', password: 'a', password_confirmation: 'a')
        @user3 = User.create!(name: 'Luke', email: 'd@a.com', password: 'a', password_confirmation: 'a')
        @user4 = User.create!(name: 'Github', email: 'g@g.com', password: 'a', password_confirmation: 'a')


        Friendship.create!(user_id: @user.id, friend_id: @user1.id)
        Friendship.create!(user_id: @user.id, friend_id: @user2.id)
        Friendship.create!(user_id: @user.id, friend_id: @user3.id)

        visit root_path

        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password

        click_button "Log In"
        visit "/new_party/#{@user.id}/princess_mononoke/134"
      end

    describe "When I visit the new viewing party page" do
      it "I see a form to make a new viewing party" do
        expect(page).to have_xpath("//input[@value='Princess Mononoke']")
        expect(page).to have_xpath("//input[@value=134]")
      end

      it "I see the names of my friends to invite with boxes to select" do
        expect(page).to have_content(@user1.name)
        find(:css, "#invitees_#{@user1.id}[value='#{@user1.id}']")
        expect(page).to have_content(@user2.name)
        find(:css, "#invitees_#{@user2.id}[value='#{@user2.id}']")
        expect(page).to have_content(@user3.name)
        find(:css, "#invitees_#{@user3.id}[value='#{@user3.id}']")
        expect(page).to_not have_content(@user4.name)
      end

      describe "When I can select friends and input a time and date" do
        before :each do
          find(:css, "#invitees_#{@user1.id}[value='#{@user1.id}']").set(true)
          find(:css, "#invitees_#{@user2.id}[value='#{@user2.id}']").set(true)
          fill_in 'party_date', with: "10/31/2020"
          fill_in 'start_time', with: '09:59 PM'
        end

        describe "I click Create Party" do
          it "I'm redirected to my dashboard" do
            click_button 'Create Party'
            expect(current_path).to eq('/user/dashboard')
          end

          it "I see the party I've created with a status of 'Host'" do
            click_button 'Create Party'

            within "#parties" do
              expect(page).to have_content("Princess Mononoke")
              expect(page).to have_content("Date: 10/31/2020")
              expect(page).to have_content("Time: 09:59 PM")
              expect(page).to have_content("Status: Host")
            end
          end
        end
      end

      describe "When I submit an incomplete form" do
        describe "With no friends selected" do
          it "I'm redirected to my dashboard" do
            fill_in 'party_date', with: "10/31/2020"
            fill_in 'start_time', with: '09:59 PM'
            click_button 'Create Party'
            expect(current_path).to eq('/user/dashboard')
          end

          it "I see the party I've created with a status of 'Host'" do
            fill_in 'party_date', with: "10/31/2020"
            fill_in 'start_time', with: '09:59 PM'
            click_button 'Create Party'

            within "#parties" do
              expect(page).to have_content("Princess Mononoke")
              expect(page).to have_content("Date: 10/31/2020")
              expect(page).to have_content("Time: 09:59 PM")
              expect(page).to have_content("Status: Host")
            end
          end
        end

        describe "With no time" do
          it "I see an error message" do
            fill_in 'party_date', with: "10/31/2020"
            click_button 'Create Party'

            expect(page).to have_content("Time can't be blank")
          end
        end

        describe "With no date" do
          it "I see an error message" do
            fill_in 'start_time', with: '09:59 PM'
            click_button 'Create Party'

            expect(page).to have_content("Date can't be blank")
          end
        end
      end
    end
  end
end
