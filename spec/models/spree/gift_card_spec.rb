require 'spec_helper'

describe Spree::GiftCard do
  it "should validate presence of name and email" do
    card = Spree::GiftCard.new
    card.valid?.should == false
    card.errors.keys.should == [:email, :name]
  end

  it "should generate token before create" do
    card = Spree::GiftCard.create(:email => "test@mail.com", :name => "John", :variant_id => 1)
    card.token.should_not == nil
  end

  it "should not allow user set line_item_id and user_id" do
    lambda {
      Spree::GiftCard.create(:email => "test@mail.com", :name => "John", :variant_id => 1, :line_item_id => 1)
    }.should raise_error(ActiveModel::MassAssignmentSecurity::Error, /line_item_id/)
    lambda {
      Spree::GiftCard.create(:email => "test@mail.com", :name => "John", :variant_id => 1, :user_id => 1)
    }.should raise_error(ActiveModel::MassAssignmentSecurity::Error, /user_id/)
  end
end
