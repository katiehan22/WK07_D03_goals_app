# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create!(username: "mike", password: "password")}

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should have_many(:goals) }

  describe "finds users by credentials" do 
    context "with valid username and password" do 
      it "returns correct user" do 
        katie = User.create(username: "hansolo", password: "password")
        user = User.find_by_credentials("hansolo", "password")

        expect(katie.username).to eq(user.username)
        expect(katie.password_digest).to eq(user.password_digest)
      end
    end
    
  end
end
