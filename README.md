# JWT Framer

JWTF allows you to configure how your JSON Web Token are generated. With JWT you
are free to choose from a few (a lot !) of options like the signing algorithm
you crave for, the associated secret key and all the reserved claims you wish to
use ! JWTF offers you a way to configure most of it for your application, so you
can concentrate on the access and policy logic you want to put inside your token.

Wow ! Jeez WTF this looks so cool ! See below for the documentation.

## Dependencies

The token generation itself is delegated to the [ruby JWT](https://github.com/jwt/ruby-jwt)
gem from its version 2.1.0.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jwtf'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jwtf

## Usage

### Configuration

Everything take place in a classic ruby configuration block :

```ruby
JWTF.configure do |config|
  # ...
end
```

In a Rails application you will typicaly use an initializer for this.

#### Token encryption algorithm

All signing algorithms available within the `jwt` gem are supported.

```ruby
JWTF.configure do |config|
  # Specify the algorithm name with an uppercased string as documented in the
  # jwt gem : https://github.com/jwt/ruby-jwt
  # Defaults to 'none'
  config.algorithm = 'HS256'

  # The secret key that will be used to encrypt the generated tokens
  # Required for algorithms different than 'none'
  config.secret = 'much secret'
end
```

TODO Implement usage and tests for HMAC other than 256, RSASSA, ECDSA

#### Dynamic payload

To get a JWT you have to call `JWTF.generate`, that's the only public method
available. Thanks to this JWTF is a convenient extension for authentication
solution like [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper).

The `JWTF.generate` method (which accepts arguments) dispatch the call to the
block given to `config.token_payload`.

For instance, if you want your JWT payload to be a two fields JSON object : the
ID of the user and a boolean which acknowledge if he is an admin or not :

```json
{
  uid: 1234,
  admin: false
}
```

Into the configuration file, implement the dynamic payload creation :

```ruby
JWTF.configure do |config|
  config.token_payload do |params|
    user = User.find(params[:user_id]

    # return the hash that will be converted into the token JSON payload
    {
      uid: params[:user_id],
      admin: user.is_admin?
    }
  end
end
```

Then just make such a call to get a new JWT :

```ruby
JWTF.generate(user_id: 1234)
```

#### Reserved claims

TODO

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/brindu/jwtf. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
