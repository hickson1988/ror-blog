require 'spec_helper'

describe Article do
  it "has a valid factory" do
    expect(FactoryGirl.create(:article)).to be_valid
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:article, title: nil)).to_not be_valid
  end

  it "is invalid with a title length less than 5 chars" do
    expect(FactoryGirl.build(:article, title: "Hi")).to_not be_valid
  end

end
