require 'sinatra/base'
require 'omniauth-twitter'
require 'active_record'
require 'pg'
require 'slim'

CONSUMER_KEY = ''
CONSUMER_SECRET = ''

#ActiveRecord::Base.configurations = YAML::load_file('config/database.yml')
#ActiveRecord::Base.establish_connection(ENV['RACK_ENV'] || 'development')
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/myapp')

#ActiveRecord::Base.establish_connection(
#  :adapter => 'sqlite3',
#  :database => 'test.sqlite3'
#)

class User < ActiveRecord::Base
  belongs_to :lab
end

class Lab < ActiveRecord::Base
  has_many :users
end

class Labsurvey < Sinatra::Base
  get '/' do
    @authed=current_user
    @lab=lab_name_ja
    if @lab
      @labs = Lab.all
    end
    slim :index
  end

  post '/submit' do
    redirect('/') if params[:lab_name] == 'none'
    redirect('/bye') if params[:lab_name] == 'bye'

    u = User.find_by(uid: session[:uid])
    u.lab_id = Lab.find_by(name: params[:lab_name])
    u.save!
    redirect '/'
  end

  get '/bye' do
    u = User.find_by(uid: session[:uid]).destroy
    session.clear
    '<a href="http://tiqav.com/2pi" target="_blank"><img alt="2pi" src="http://tiqav.com/2pi.jpg" /></a>'
  end

  helpers do
    def current_user
      !session[:uid].nil?
    end

    def lab_name
      return nil unless current_user
      u = User.find_by(uid: session[:uid])
      return nil unless u.lab
      u.lab.name
    end

    def lab_name_ja
      return nil unless current_user
      u = User.find_by(uid: session[:uid])
      return nil unless u.lab
      u.lab.name_ja
    end
  end

########
# Auth #
########
  configure do
    enable :sessions

    use OmniAuth::Builder do
      provider :twitter, CONSUMER_KEY, CONSUMER_SECRET
    end
  end
  
  before do
    pass if request.path_info =~ /^\/auth\//
    #redirect to('/auth/twitter') unless current_user
  end

  get '/auth/:name/callback' do
    user = User.find_or_create_by(uid: env['omniauth.auth'][:uid])
    user[:name] = env['omniauth.auth']['info']['name']
    user[:screen_name] = env['omniauth.auth']['info']['nickname']
    user[:lab_id] = nil unless user[:lab_id]
    user.save!
    session[:uid] = env['omniauth.auth']['uid']
    redirect to('/')
  end

  get '/auth/failure' do
    'failure'
  end


end

if __FILE__ == $0
  Labsurvey.run! :host => '127.0.0.1', :port => 8080
end
