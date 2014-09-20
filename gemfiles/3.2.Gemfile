# coding: utf-8

source 'https://rubygems.org'

gemspec

group :development do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git'
  gem 'bogus'
  gem 'activerecord', '~> 3.2.19'
  gem 'sqlite3'
end

group :release do
  gem 'gem-release'
end

# Added by devtools
eval_gemfile '../Gemfile.devtools'
