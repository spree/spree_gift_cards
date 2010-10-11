class AddGiftCardAttrToProducts < ActiveRecord::Migration
  def self.up
    change_table(:products) do |t|
      t.column :is_gift_card, :boolean, :default => false, :null => false
    end  
  end

  def self.down
    change_table(:products) do |t|
      t.remove :is_gift_card
    end
  end
end
