require "rubygems"
require "bundler/setup"
require "sinatra"
require "haml"
$LOAD_PATH.unshift File.expand_path('.')
require "app"

set :run, false
set :raise_errors, true

run Sinatra::Application
