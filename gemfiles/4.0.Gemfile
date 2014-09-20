# coding: utf-8

source 'https://rubygems.org'

gemspec

group :development do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git'
  gem 'bogus'
  gem 'activerecord', '~> 4.0.10'

  platform :mri do
    gem 'sqlite3'
  end

  platform :jruby do
    group :jruby do
      gem 'activerecord-jdbcsqlite3-adapter'
    end
  end
end

group :release do
  gem 'gem-release'
end

# Added by devtools
eval_gemfile '../Gemfile.devtools'
