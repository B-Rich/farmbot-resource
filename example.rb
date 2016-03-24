require_relative './lib/farmbot-resource'
require 'pry'
token = FbResource::Client.get_token(email: 'admin@admin.com',
                                     password: 'password123',
                                     # Defaults to "my.farmbot.io" if not specified.
                                     url: "http://localhost:3000")

client = FbResource::Client.new do |config|
  # Note for users that self host a Farmbot API:
  # FbResource will grab the URL from the token's "ISS" claim.
  config.token = token
end

puts ("Grabbing schedules")
client.schedules.all # => []

puts ("Grabbing plants")
client.plants.all # => []

puts ("Grabbing sequences")
client.sequences.all # => []

puts ("Grabbing devices")
puts client.device.current # => []
