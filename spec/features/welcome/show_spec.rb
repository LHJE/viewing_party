require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Welcome Page' do
  describe 'As a visitor' do
    before :each do
      visit root_path
    end

    it "I can see a brief description of the application" do
      expect(page).to have_content("This is the premier website for planning your next movie night!")
    end

    it "I can see a button to log in" do
      expect(page).to have_button("Log In")
    end

    it "I can see a link to register" do
      expect(page).to have_link("Register")
    end
  end

  describe 'As an authenticated user' do
    describe "When I visit the discover page" do
      before :each do
        @user_1 = User.create(name: 'Jackie Chan', email: '12@12.com', password: '12', password_confirmation: '12')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
        visit root_path
      end

      it "I can see a welcome message" do
        expect(page).to have_content("Welcome to Viewing Party!")
      end

      it "I can see a brief description of the application" do
        expect(page).to have_content("This is the premier website for planning your next movie night!")
      end

      it "I can see a button to log in" do
        expect(page).to_not have_button("Log In")
      end

      it "I can see a link to register" do
        expect(page).to_not have_link("Register")
      end
    end
  end
end
