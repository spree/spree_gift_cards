class GiftCard < ActiveRecord::Base
  belongs_to :variant
  belongs_to :line_item
  belongs_to :user
  validates :email, :presence => true
  validates :name, :presence => true
  
  before_create :generate_token
  
  private
  
	def generate_token
	  self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
	end
end
