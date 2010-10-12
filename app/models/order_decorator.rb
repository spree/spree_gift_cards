Order.class_eval do
  # Finalizes an in progress order after checkout is complete.
  # Called after transition to complete state when payments will have been processed
  def finalize!
    self.out_of_stock_items = InventoryUnit.sell_units(self) if Spree::Config[:track_inventory_levels]
    update_attribute(:completed_at, Time.now)
    # lock any optional adjustments (coupon promotions, etc.)
    adjustments.optional.each { |adjustment| adjustment.update_attribute("locked", true) }
    OrderMailer.confirm_email(self).deliver
    self.line_items.each do |li|
      OrderMailer.gift_card_email(li.gift_card).deliver if li.gift_card
    end
  end
end
