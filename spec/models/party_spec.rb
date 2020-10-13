require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :movie_title}
    it {should validate_presence_of :user_id}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
  end
end
