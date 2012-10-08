Deface::Override.new(:virtual_path => "spree/orders/_line_item",
                     :name => "replace_cart_item_description",
                     :replace => "[data-hook='cart_item_description']",
                     :partial => %q{spree/orders/line_item_description},
                     :disabled => false)
