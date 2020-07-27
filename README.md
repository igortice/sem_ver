# SemVer

The gem creates a yml file in the public folder in which it can be filled and consumed, at any time, to generate information based on the concept of semantic versioning.

The concept of the gem is very simple, whenever you need to add a version based on semantic versioning just use the gem methods, your version will be saved in the file and for information like current version, version listing, just use other methods of gem.

Why use a file instead of the database, the answer is simple, if you work with various environments such as approval and production you must have banks for each version and as the concept here is to always have the same versions for both environments, so the use of the file makes this possible since you can commit the file in devel, for example, and share in all environments through the merge of the vcs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sem_ver'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sem_ver

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/igortice/sem_ver. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/igortice/sem_ver/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SemVer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/igortice/sem_ver/blob/master/CODE_OF_CONDUCT.md).
