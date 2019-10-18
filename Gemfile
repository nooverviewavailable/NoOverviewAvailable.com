# frozen_string_literal: true

source 'https://rubygems.org'

gem 'jekyll', '~> 4.0.0'

group :jekyll_plugins do
  gem 'jekyll-tidy'
end

gem 'activesupport'
gem 'liquid-c', require: 'liquid/c'
gem 'oj'
gem 'parallel'
gem 'sassc'

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
install_if -> { RUBY_PLATFORM =~ /mingw|mswin|java/ } do
  gem 'tzinfo', '~> 1.2'
  gem 'tzinfo-data'
end

# Performance-booster for watching directories on Windows
gem 'wdm', '~> 0.1.1', install_if: Gem.win_platform?

group :rakefile do
  gem 'kimurai'
  gem 'mechanize'
  gem 'nokogiri'
  gem 'odyssey'
  gem 'rake'
end
