require 'rails_helper'

RSpec.describe User do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password}
  end

  it ".all_parties" do
    user_1 = User.create(name: 'Jackie Chan', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    user_2 = User.create(name: 'Cynthia Rothrock', email: 'b@b.com', password: 'b', password_confirmation: 'b')
    user_3 = User.create(name: 'Michelle Yeoh', email: 'c@c.com', password: 'c', password_confirmation: 'c')

    party_1 = Party.create(movie_title: "The Exorcist III",user_id: user_1.id, date: "October 26th, 1997", time: "1:45pm")
    party_2 = Party.create(movie_title: "Psycho II",user_id: user_1.id, date: "June 2nd, 1998", time: "2:45pm")
    party_4 = Party.create(movie_title: "House II: The Second Story",user_id: user_2.id, date: "April 22nd, 2000", time: "4:45pm")
    party_5 = Party.create(movie_title: "The Gate II",user_id: user_2.id, date: "January 19nd, 2001", time: "5:45pm")

    partyuser_7 = PartyUser.create(party_id: party_4.id, user_id: user_1.id, status: 1)

    expect(user_1.all_parties).to eq([party_1, party_2, party_4])
    expect(user_1.all_parties).to_not include(party_5)
  end
end
