module SpreeGiftCards
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Configures your Rails application for use with spree_gift_cards"

      def copy_migrations
        directory "db"
      end

      def run_db_seeds
        seed_file = File.join(File.expand_path("../../../../db", __FILE__), "seeds.rb")
        load(seed_file) if File.exist?(seed_file)
      end
    end
  end
end

