#!/usr/bin/env ruby
require 'json'
require 'httparty'

usertoken = ENV['shop_token']
opts = { token: usertoken }


out = Hash.new
out["items"] = []

query = ARGV[0]

response = HTTParty.post("https://shop.kovanen.se/api/list.html", body: opts)
resp = JSON.parse(response.body)

items = resp["items"]

items.each do |item|
  out["items"].push({"type" => "default", "title" => "#{item["item"]}", "subtitle" => "Quantity: #{item["quantity"]} Shop: #{item["list"]}", "arg" => "remove,#{item["id"]}" })
end

print out.to_json
