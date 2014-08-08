# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_spreadsheet_seed'
  s.version     = '2.2.11'
  s.summary     = 'Add products from excel spreadsheet'
  s.description = 'Add products from excel spreadsheet'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Fel'
  s.email     = 'felipe@reuoutdoor.com'
  # s.homepage  = 'http://www.spreecommerce.com'

  #s.files = Dir["lib/**/*"] + Dir["app/**/**/**/*"] 
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.2.0'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails', '~> 4.0.2'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'jquery-fileupload-rails'
  s.add_development_dependency 'roo'
end
