require 'sinatra'
require 'sinatra/base'
require "sinatra/reloader" if development?
require 'coffee-script'
#require "digest/sha1"
require 'json'
require 'mongoid'
#require 'sinatra-authentication'
require 'fileutils'
require 'sinatra/flash'

#require 'sinatra/redirect_with_flash'  
#require 'v8'
require_relative './models'



Mongoid.load!(File.dirname(__FILE__) + '/config/mongoid.yml')

puts 'env is:'
puts ENV['RACK_ENV']

configure :development do
	#register Sinatra::Reloader
	set :peeps_limit, 120
end

configure :test do
	set :peeps_limit, 3
end

SessionSecret = ADD SESSION KEY

helpers do
  include Rack::Utils  
  alias_method :h, :escape_html  

  def bar(name)
    "#{name}bar"
  end

end

use Rack::Session::Cookie, :expire_after => 2592000, :secret => SessionSecret
#set :session_secret, SessionSecret	


get '/' do 
	erb :index
end	



require_relative './controllers/peeps'
require_relative './controllers/auth'
require_relative './controllers/profile'



def auth_peep(username, password) 
	Peep.exists?(conditions: { username: username, password: password } )
end