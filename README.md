# File Manager

[![Build Status][BS img]][Build Status]

File manager gem for handling different storage implementations. Currently only supports S3.

[Build Status]: https://travis-ci.org/galkon/file_manager
[BS img]: https://travis-ci.org/galkon/file_manager.svg?branch=master

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'file_manager'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install file_manager

## Usage

```RUBY
# Upload a file to s3 with a private ACL
FileManager::S3.store(file_path: "foo/bar.json", file: <File Object>, bucket: 's3-bucket')

# Upload a file to s3 with a public ACL
FileManager::S3.store(file_path: "foo/bar.json", file: <File Object>, bucket: 's3-bucket', acl: 'public')

# Delete a file from s3
FileManager::S3.delete(file_path: "foo/bar.json", bucket: 's3-bucket')

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/galkon/file_manager.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
