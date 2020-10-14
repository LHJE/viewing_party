require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :movie_title}
    it {should validate_presence_of :user_id}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
  end

  it "can determine a users status" do
    user_1 = User.create(name: 'Jackie Chan', email: 'qw@qw.com', password: 'qw', password_confirmation: 'qw')
    user_2 = User.create(name: 'Cynthia Rothrock', email: 'ty@b.com', password: 'b', password_confirmation: 'b')
    user_3 = User.create(name: 'Michelle Yeoh', email: 'ty@c.com', password: 'c', password_confirmation: 'c')
    user_4 = User.create(name: 'Bilbo Baggins', email: 'ty@d.com', password: 'd', password_confirmation: 'd')
    party_1 = Party.create(movie_title: "The Exorcist III", user_id: user_1.id, date: "October 26th, 1997", time: "1:45pm")

    expect(party_1.user_status(user_1.id)).to eq('Host')
    expect(party_1.user_status(user_2.id)).to eq('Invited')
    expect(party_1.user_status(user_3.id)).to eq('Invited')
    expect(party_1.user_status(user_4.id)).to eq('Invited')
  end
end
