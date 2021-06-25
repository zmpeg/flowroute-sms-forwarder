#!/usr/bin/env ruby
require 'sinatra'
require 'json'
require 'net/http'
require 'uri'

set :bind, '0.0.0.0'

puts "Listening at #{ENV["FLOWROUTE_CALLBACK_PATH"]}..."

post ENV["FLOWROUTE_CALLBACK_PATH"] do
  msg = JSON.parse(request.body.read)
  puts "#{msg['from']}: #{msg['body']}"

  uri = URI.parse("https://api.flowroute.com/v2/messages")
  request = Net::HTTP::Post.new(uri)
  request.basic_auth(ENV["FLOWROUTE_KEY"], ENV["FLOWROUTE_SECRET"])
  request.content_type = "application/json"
  request.body = JSON.dump({
    "to" => ENV["FLOWROUTE_FORWARD_NUMBER"],
    "from" => ENV["FLOWROUTE_FROM_DID"],
    "body" => "#{msg['from']}: #{msg['body']}"
  })

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  'OK'
end

not_found do
  '404'
end
