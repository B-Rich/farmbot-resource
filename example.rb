require_relative './lib/farmbot-resource'
require 'pry'
token = FbResource::Client.get_token(email: 'admin@admin.com',
                                     password: 'password123',
                                     # Defaults to "my.farmbot.io" if not specified.
                                     url: "http://localhost:3000")

client = FbResource::Client.new do |config|
 config.token = token
 config.url   = 'http://localhost:3000'
end
