Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_gift_cards'
  s.version     = '1.0.0.beta'
  s.summary     = 'Spree Gift Cards'
  s.description = 'Spree Gift Card Extension'

  s.author      = ['Jeff Dutil', 'Roman Smirnov']
  s.email       = ['jdutil@railsdog.com', 'roman@railsdog.com']
  s.homepage    = 'http://github.com/spree/spree_gift_cards'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_path = 'lib'
  s.required_ruby_version = '>= 1.9.2'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 1.0.0', '< 1.2.0'
  s.add_dependency 'spree_auth', '>= 1.0.0', '< 1.2.0'
  s.add_dependency 'spree_store_credits', '>= 0.30.0'

  s.add_development_dependency 'capybara', '~> 1.0'
  s.add_development_dependency 'factory_girl', '~> 3.5'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.11'
  s.add_development_dependency 'sqlite3'
end
