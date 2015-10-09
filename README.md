# Farmbot Resource

Adapter gem for Farmbot Web App API. Currently used in Raspberry Pi controller to support scheduling operations.

# Available Resources

 * Sequences
 * Schedules
 * Plants

Need more than what's available? Raise an issue.

# Usage

```ruby
client = FbResource::Client.new do |config|
  config.uuid  = 'xyxyxyxy-1234-5678-5345-453453453453'
  config.token = '229458cgsdfgsdfgsdfaasdfasdfasdfasdfasda'
  config.url   = 'http://my.farmbot.it'
end

# Simple use case: get all schedules
# Returns array of hashes
schedules = client.schedules.all

# Another use case: cache busting with fetch()
# Results are always cached until fetch() is called
sequences = client.sequences.fetch.all

```
