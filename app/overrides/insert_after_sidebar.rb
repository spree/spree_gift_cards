Deface::Override.new(:virtual_path => "spree/layouts/spree_application",
                     :name => "insert_after_sidebar",
                     :insert_after => "#sidebar, [data-hook='sidebar']",
                     :text => %q{<%= link_to t("buy_gift_card"), new_gift_card_path, :class => 'button' %>},
                     :disabled => false)
