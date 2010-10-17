require 'spec_helper'

describe "A new GiftCard" do
 	it "should validate presence of name and email" do
 	  card = GiftCard.new
 	  card.valid?.should == false
 	  card.errors.keys.should == [:email, :name]
 	end
 	
 	it "should generate token before create" do
 	  card = GiftCard.create(:email => "test@mail.com", :name => "John", :variant_id => 1)
 	  card.token.should_not == nil
 	end
 	
 	it "should not allow user set line_item_id and user_id" do
 	  card = GiftCard.create(:email => "test@mail.com", :name => "John", :variant_id => 1, :user_id => 1, :line_item_id => 1)
 	  card.line_item_id.should == nil
 	  card.user_id.should == nil
 	end
end
