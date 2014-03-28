require './app.rb'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
ActiveRecord::Base.establish_connection(YAML::load_file('config/database.yml')[ENV['RACK_ENV']])
