Order.class_eval do
  # Finalizes an in progress order after checkout is complete.
  # Called after transition to complete state when payments will have been processed
  def finalize_with_gift_card!
    debugger
    finalize_without_gift_card!
    self.line_items.each do |li|
      OrderMailer.gift_card_email(li.gift_card).deliver if li.gift_card
    end
  end
  alias_method_chain :finalize!, :gift_card

end
