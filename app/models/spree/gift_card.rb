module Spree
  class GiftCard < ActiveRecord::Base
    belongs_to :variant
    belongs_to :line_item
    belongs_to :user
    validates :email, :presence => true
    validates :name, :presence => true

    before_create :generate_token

    attr_accessible :name, :email, :note, :variant_id

    def price
      self.line_item ? self.line_item.price * self.line_item.quantity : self.variant.price
    end

    def register(user)
      self.update_attribute(:is_received, true)

      StoreCredit.create(:amount => self.price, :remaining_amount => self.price,
                         :reason => "Gift card #{token}.", :user => user)
    end

    private

    def generate_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end
  end
end
