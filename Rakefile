task :default => :run

task :run do
  sh "ruby app.rb"
end

task :shotgun do
  sh "shotgun app.rb"
end


def bc(source, destination = source.split("/")[-1])
  destination = destination.split(".")[-1] + "/" + destination
  sh "cp bower_components/#{source} static/#{destination}"
end

task :assets do
  bc "bootstrap/dist/css/bootstrap.css"
  bc "bootstrap-material-design/dist/css/bootstrap-material-design.css"
  bc "bootstrap-material-design/dist/css/ripples.css"

  bc "bootstrap-material-design/dist/js/material.js"
  bc "bootstrap-material-design/dist/js/ripples.js"
  bc "bootstrap/dist/js/bootstrap.js"
  bc "jquery/dist/jquery.js"
end
