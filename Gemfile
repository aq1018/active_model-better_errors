# coding: utf-8

source 'https://rubygems.org'

gemspec

group :development do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git'
  gem 'bogus'
  # rainbow 2.x is not compatible with rubocop ( yet )
  gem 'rainbow', '~> 1.99.2'
end

group :release do
  gem 'gem-release'
end

# Added by devtools
eval_gemfile 'Gemfile.devtools'
