# Ruby Zeus Client

![Alt text](/icons/zeus-logo.png?raw=true "Zeus Logo")

Ruby client for [Cisco Zeus](http://www.ciscozeus.io/). This allows us to send and recieve data to and from Zeus.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zeusclient'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zeusclient

## Usage

```ruby
require 'zeus/api_client'
zeus_client = Zeus::APIClient.new({
    :access_token => "your_token_here"
})
```

List All Metrics
```ruby
result = zeus_client.list_metrics()
p result.code  # 200
p result.data  # => {}
```

Get Metric
```ruby
result = zeus_client.get_metrics()
p result.code  # 200
p result.data  # => {}
```

Delete metric
```ruby
result = zeus_client.delete_metrics()
p result.code  # 200
p result.data  # => {}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/zeusclient/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
