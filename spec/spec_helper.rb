require 'bundler'
Bundler.require
require 'audit'
Dir[File.expand_path("../support/*.rb", __FILE__)].each {|f| require f}
