#!/usr/bin/ruby


require "sinatra"
require "uri"
require "json"
require "./CirculaDateTime.rb"

set :public_folder, File.dirname(__FILE__) + '/static'

def parse_timeline(raw)
  items = Array.new
  raw.split("\n").each do |line|
    elements = line.split(",")
    items.push({
      "date" => CirculaDateTime.parse(elements[0].strip),
      "title" => elements[1].strip,
      "href" => elements[2].strip
    })
  end
  return items
end

get "/" do
  @timeline = parse_timeline(File.read("timeline")).sort_by{|item| item["date"]}
  @timeline_json = JSON.generate(@timeline)
  erb :index
end

get "/timeline" do
  @timeline = File.read("timeline")
  erb :timeline
end

post "/timeline" do
  if request.media_type == "application/x-www-form-urlencoded"
    body = params["timeline"] || request.body.read
  else
    halt 415
  end

  begin
    parse_timeline(body)
  rescue ArgumentError
    halt 400
  end

  File.write("timeline", body)
  redirect "/"
end
