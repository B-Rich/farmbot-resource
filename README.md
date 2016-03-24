# Farmbot Resource

Adapter gem for Farmbot Web App API. Currently used in Raspberry Pi controller to support scheduling operations.

# Available Resources

 * Sequences
 * Schedules
 * Plants

Need more than what's available? Raise an issue and we can add your resource to the list (PRs are also welcome).

# Usage

First, you will need an API token.

```ruby
token = FbResource::Client.get_token(email: 't@g.com',
                                     password: 'shhh...',
                                     # OPTIONAL: Defaults to "my.farmbot.io"
                                     # if not specified.
                                     url: "http://localhost:3000")
# Returns really long JSON Web Token...
# => 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9....'
```

Once you have an API token, you can create a 'client'.

```ruby
client = FbResource::Client.new do |config|
  config.token = token
end
```

Client objects can access API resources such as schedules and sequences.

```ruby
# Simple use case: get all schedules
# Returns array of hashes
schedules = client.schedules.all

# Another use case: cache busting with fetch()
# Results are always cached until fetch() is called
sequences = client.sequences.fetch.all

```

**See example.rb for a runnable sample**.
