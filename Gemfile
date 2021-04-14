source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rack-cors', '~> 1.1', '>= 1.1.1'
gem 'bcrypt', '~> 3.1', '>= 3.1.16'
gem 'jwt', '~> 2.2', '>= 2.2.2'
gem 'will_paginate', '~> 3.3'
gem 'active_model_serializers', '~> 0.10.12'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0', '>= 5.0.1'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.17'
end

group :development do
  gem 'listen', '~> 3.5', '>= 3.5.1'
  gem 'pry', '~> 0.14.1'
  gem 'rubocop', '~> 1.12', '>= 1.12.1'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', '~> 2.2'
  gem 'spring', '~> 2.1', '>= 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0', '>= 2.0.1'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.0'
  gem 'shoulda-matchers', '~> 4.5', '>= 4.5.1'
  gem 'simplecov', '~> 0.21.2'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
