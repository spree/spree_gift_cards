Deface::Override.new(:virtual_path => "spree/users/show",
                     :name => "insert_after_account_my_orders",
                     :insert_after => "[data-hook='account_my_orders']",
                     :partial => %q{spree/users/gift_cards},
                     :disabled => false)
