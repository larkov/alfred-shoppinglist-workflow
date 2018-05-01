#!/usr/bin/env ruby
require 'json'
require 'httparty'

out = Hash.new
out['items'] = []

usertoken = ENV['shop_token']

query = ARGV[0].split(",")

case query[0]
when "remove"
  itemid = query[1].strip

  opts = {
    token: usertoken,
    itemid: itemid
  }

  response = HTTParty.post("https://shop.kovanen.se/api/delete.html", body: opts)
  resp = JSON.parse(response.body)

  if resp["success"]
    puts "Removed #{itemid}"
  else
    puts "Something failed."
  end
else
  puts "Something failed."
end

