source 'https://rubygems.org'

ruby '3.4.4'

gem 'rails', '~> 7.1.3', '>= 7.1.3.4'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 6.4'
gem 'bootsnap', require: false

# Testing utilities
group :test do
  gem 'rails-controller-testing'
end

group :development, :test do
  gem 'debug', platforms: [:mri]
end

group :production do
  gem 'pg'
end
