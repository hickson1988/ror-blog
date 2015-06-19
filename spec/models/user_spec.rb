require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without a first name" do
    expect(FactoryGirl.build(:user, first_name: nil)).to_not be_valid
  end

  it "is invalid without a last name" do
    expect(FactoryGirl.build(:user, last_name: nil)).to_not be_valid
  end

  it "has a valid email format" do
    expect(FactoryGirl.build(:user, email: "test@test.com")).to be_valid
  end

   describe "password validation" do

      it "is invalid with a password length less than 5 chars" do
        expect(FactoryGirl.build(:user, password: "1234")).to_not be_valid
      end

      it "is invalid with a password length larger than 20 chars" do
        expect(FactoryGirl.build(:user, password: "123456789123456789abcde")).to_not be_valid
      end

  end
end
