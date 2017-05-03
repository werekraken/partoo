[![Version     ](https://img.shields.io/gem/v/partoo.svg?style=flat)](https://rubygems.org/gems/partoo)
[![Build Status](https://img.shields.io/travis/werekraken/partoo/master.svg?style=flat)](https://travis-ci.org/werekraken/partoo)

# Partoo

Do cool things with par2 files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'partoo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install partoo

## Usage

```
Commands:
  partoo dump <par2 file>                 # Dump packets in a par2 file as a data structure
  partoo help [COMMAND]                   # Describe available commands or one specific command
  partoo inspect <attribute> <par2 file>  # Inspect a particular attribute of a par2 file
  partoo list <par2 file>                 # Lists files described in a par2 file
  partoo tomd5 <par2 file>                # Build an md5 file from par2 file data
  partoo tosfv <par2 file>                # Build an sfv file from par2 file data
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/werekraken/partoo.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

