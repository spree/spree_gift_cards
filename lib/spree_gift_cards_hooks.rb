class SpreeGiftCardsHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_product_form_right , "admin/products/gift_card_fields"
  
  insert_after :sidebar do
    %(
    <%= link_to t("buy_gift_card"), new_gift_card_path, :class => 'button' %>
    )
  end
  
  replace :cart_item_description, "orders/line_item_description"
end
