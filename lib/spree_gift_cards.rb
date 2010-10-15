require 'spree_core'
require 'spree_gift_cards_hooks'

module SpreeGiftCards
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env == "production" ? require(c) : load(c)
      end
      
      User.has_many :gift_cards
      LineItem.has_one :gift_card
    end

    config.to_prepare &method(:activate).to_proc
  end
end
