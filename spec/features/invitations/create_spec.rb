require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe FriendNotifierMailer, type: :mailer do
  describe 'inform' do
    @user_1 = User.create(name: 'Jackie Chan', email: '23@23.com', password: '23', password_confirmation: '23')
    @user_2 = User.create(name: 'Cynthia Rothrock', email: 'we@we.com', password: 'b', password_confirmation: 'b')
    @friendship_1 = Friendship.create(user_id: @user_1.id, friend_id: @user_2.id)
    @friendship_2 = Friendship.create(user_id: @user_2.id, friend_id: @user_1.id)
    @party_1 = Party.create(movie_title: "The Exorcist III", user_id: @user_1.id, date: "October 26th, 1997", time: "1:45pm")
    @party_user_1 = PartyUser.create(party_id: @party_1.id, user_id: @user_2.id, status: 2)

    sending_user = User.create(
      name: @user_1.name,
      email: @user_1.email,
      password: @user_1.password
    )

    email_info = {
      user: sending_user,
      friend: @user_2.name,
      message: "Come to my Viewing Party! We are watching '#{@party_1.movie_title}'"
    }

    let(:mail) { FriendNotifierMailer.inform(email_info, 'b@b.com') }

    it 'renders the headers' do
      expect(mail.subject).to eq("Rejoice Cynthia Rothrock! Jackie Chan is sending you an invitation to a Viewing Party!")
      expect(mail.to).to eq(['b@b.com'])
      expect(mail.from).to eq(['viewing@party.io'])
      expect(mail.reply_to).to eq(['23@23.com'])
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include('Hello Cynthia Rothrock')
      expect(mail.text_part.body.to_s).to include("Jackie Chan has sent you a Viewing Party invitation: Come to my Viewing Party! We are watching 'The Exorcist III'")

      expect(mail.html_part.body.to_s).to include('Hello Cynthia Rothrock')
      expect(mail.html_part.body.to_s).to include("Jackie Chan has sent you a Viewing Party invitation: Come to my Viewing Party! We are watching &#39;The Exorcist III&#39;")

      expect(mail.body.encoded).to include('Hello Cynthia Rothrock')
      expect(mail.body.encoded).to include("Jackie Chan has sent you a Viewing Party invitation: Come to my Viewing Party! We are watching 'The Exorcist III'")
    end
  end
end
