require './app.rb'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
ActiveRecord::Base.establish_connection(ENV['RACK_ENV'] || 'postgres://localhost/myapp')
