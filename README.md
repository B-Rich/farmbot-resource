# Farmbot Resource

Adapter gem for Farmbot Web App API

# Note

This Gem is not in a working state. It is in a public pre-alpha.

# Usage

```ruby
client = FbResource::Client.new do |config|
  config.uuid  = 'xyxyxyxy-1234-5678-5345-453453453453'
  config.token = '229458cgsdfgsdfgsdfaasdfasdfasdfasdfasda'
  config.url   = 'http://my.farmbot.it'
  config.on_load do |client|
    # Load any objects that you persisted elsewhere
  end
end

schedules = client.schedules

# get a step from a sequence from a step
sequence  = schedules
              .first
              .sequence
              .steps
              .first

```
