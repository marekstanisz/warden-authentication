source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'
gem 'sqlite3'
gem 'puma', '~> 3.7'

gem 'haml'

gem 'bcrypt'
gem 'warden'
gem 'virtus'

gem 'pry'
gem 'pry-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
end

group :test do
  gem 'warden-rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end
