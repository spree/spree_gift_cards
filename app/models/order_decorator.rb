Order.class_eval do
  # Finalizes an in progress order after checkout is complete.
  # Called after transition to complete state when payments will have been processed
  def finalize_with_gift_card!
    finalize_without_gift_card!
    self.line_items.each do |li|
      OrderMailer.gift_card_email(li.gift_card, self).deliver if li.gift_card
    end
  end
  alias_method_chain :finalize!, :gift_card

  def contains?(variant)
    return false if variant.product.is_gift_card?
    line_items.detect{|line_item| line_item.variant_id == variant.id}
  end

end
