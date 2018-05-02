#!/usr/bin/env ruby
# encoding: utf-8

require 'json'
require 'httparty'
require 'active_support/all'

out = Hash.new
out['items'] = []

usertoken = ENV['shop_token']

query = ARGV[0].split(",")

case query[0]
when "add"
  item = query[1].strip.mb_chars.normalize
  quantity = if query[2] then query[2].strip else "" end

  opts = {
    token: usertoken,
    item: item,
    quantity: quantity
  }

  response = HTTParty.post("https://shop.kovanen.se/api/add.html", body: opts)
  resp = JSON.parse(response.body)

  if resp["success"]
    puts resp["message"]
  else
    puts "Something failed."
  end
else
  item = query[0].strip
  quantity = if query[1] then query[1].strip else "" end
  out["items"].push({"type" => "default", "title" => "#{item}", "subtitle" => "Quantity: #{quantity} List: Ospecifierad", "arg" => "add,#{item},#{quantity}" })

  puts out.to_json
end

