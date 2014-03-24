require 'sinatra/base'
require 'omniauth-twitter'
require 'active_record'

CONSUMER_KEY = 'vAGbw6X00d9Cep8DfubEJA'
CONSUMER_SECRET = 'i3Nn5nwaU5PiJoXj8x6Ffj1HHmGnBDdcKijM2NRdmQA'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(ENV['RACK_ENV'])

class User < ActiveRecord::Base

end

class Labsurvey < Sinatra::Base
  configure do
    enable :sessions

    use OmniAuth::Builder do
      provider :twitter, CONSUMER_KEY, CONSUMER_SECRET
    end
  end
  
  before do
    pass if request.path_info =~ /^\/auth\//
    redirect to('/auth/twitter') unless current_user
  end

  get '/auth/:name/callback' do
    session[:uid] = env['omniauth.auth']['uid']
    redirect to('/')
  end

  get '/auth/failure' do
    'failure'
  end

  get '/' do
    'index'
  end

  helpers do
    def current_user
      !session[:uid].nil?
    end
  end
end

#Labsurvey.run! :host => '127.0.0.1', :port => 8080
