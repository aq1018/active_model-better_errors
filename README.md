# ActiveModel Better Errors

`activemodel-better-errors` is a `ActiveModel::Errors` compatible library to help you
customize the presentation of your error messages by specifying.

## Why Better Errors

In `ActiveModel::Errors`, when an error is added, it is pre translated into human readable string.
However, this becomes less ideal when output error messages in JSON or XML in your API.
Most of the times, we want error codes instead of human readable strings. This will allow
API consumers to translate them in their own application and provide more flexibility for your
API.

## How Better Errors Work

`activemodel-better-errors` works by sperating the concerns of error message storage and presentation.
`ActiveModel::Errors` really handles four tasks in a single class:

* error data storage
* presenting human readable errors using `#full_messages`
* presenting errors in Array / XML format with `#to_a` and `#to_xml`
* presenting errors in Hash / JSON format with `#to_hash` and `#as_json`

This gem seperates these concerns and allows users to plugin various reporters for different presentation needs.

## Setup

### With Bundler

```ruby
# in Gemfile
gem 'activemodel-better-errors', '~> 1.2.0'
```

```
# in console
bundle install
```

### With RubyGems

```
gem install activemodel-better-errors
```

## Configure

By default, `activemodel-better-errors` is a drop-in replacement for `ActiveModel::Errors`
and will mostly function without modifications. This is because the default reporters are set like the following:

```ruby
ActiveModel::ErrorCollecting.set_reporter :message,  :human
ActiveModel::ErrorCollecting.set_reporter :array,    :human
ActiveModel::ErrorCollecting.set_reporter :hash,     :human
```

If you want to output API friendly JSON / XML by default, you can use the following config.

```ruby
ActiveModel::ErrorCollecting.set_reporter :message,  :human
ActiveModel::ErrorCollecting.set_reporter :array,    :machine
ActiveModel::ErrorCollecting.set_reporter :hash,     :machine
```

Note: The configurations above determines *default* reporters to use, you can always switch to
any reporters you want during runtime by invoking `errors.set_reporter`

## Usage

```ruby
user.errors # returns an instance of ActiveModel::ErrorCollecting::Errors

# Use MachineArrayReporter to output API friendly error messages
user.errors.set_reporter(:array, :machine)
user.errors.to_a   # API Friendly
user.errors.to_xml # API Friendly

# Use HumanArrayReporter to output Human friendly error messages.
# This is ActiveModel::Errors behavior
user.errors.set_reporter(:array, :human)
user.errors.to_a   # Human Friendly
user.errors.to_xml # Human Friendly

# Use MachineHashReporter to output API friendly error messages
user.errors.set_reporter(:hash, :machine)
user.errors.to_hash # API Friendly
user.errors.as_json # API Friendly
user.errors.to_json # API Friendly


# Use HumanHashReporter to output Human friendly error messages.
# This is ActiveModel::Errors behavior
user.errors.set_reporter(:hash, :human)
user.errors.to_hash # Human Friendly
user.errors.as_json # Human Friendly
user.errors.to_json # Human Friendly

# Use MyHashReporter to output Human friendly error messages.
# This is ActiveModel::Errors behavior
user.errors.set_reporter(:hash, MyHashReporter)
user.errors.to_hash # custom behavior
user.errors.as_json # custom behavior
user.errors.to_json # custom behavior

```

## In Depth

This library creates three types of reporters to take care of
some presentation aspects of `ActiveModel::Errors`, and they are:

**Message Reporters**

This is responsible for handling the following methods in `ActiveModel::Errors`

* `#full_messages`
* `#full_message`
* `#generate_message`

Due to the conventional use of these methods, they are mostly intended for human consumption.

This library implements the following reporters of this type:

* `HumanMessageReporter`

**Array Reporters**

This is responsible for handling the following methods in `ActiveModel::Errors`

* `#to_a`

This library implements the following reporters of this type:

* `HumanArrayReporter`
* `MachineArrayReporter`

**Hash Reporters**

This is responsible for handling the following methods in `ActiveModel::Errors`

* `#to_hash`

This library implements the following reporters of this type:

* `HumanHashReporter`
* `MachineHashReporter`


## Creating Custom Reporters

Creating a custom reporter is easy. Here is an example to create a hash reporter

```ruby
class MyHashReporter < ActiveModel::ErrorCollecting::HashReporter
  def to_hash
    # you have access to #collection and #base
  end
end

# set it to use it.
ActiveModel::ErrorCollecting.set_reporter :hash, MyHashReporter
```

## Contributing to activemodel-better-errors

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 Aaron Qian. See LICENSE.txt for
further details.

