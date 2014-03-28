require './app.rb'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/myapp')
