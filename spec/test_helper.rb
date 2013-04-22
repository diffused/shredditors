require 'minitest/autorun'
require 'rack/test'
#require 'mongoid'

ENV['RACK_ENV'] = 'test'

class Setup
	def create_peeps
		Peep.create(username: 'diffused', password: 'pass', home_mountain: 'Turoa')
		Peep.create(username: 'revert', password: 'pass', home_mountain: 'Turoa')
		Peep.create(username: 'James', password: 'pass', home_mountain: 'Whakapapa')	
		Peep.create(username: 'name with spaces', password: 'pass', home_mountain: 'Not Turoa')
		Peep.create(username: 'owen', password: 'pass', home_mountain: 'Turoa')
		Peep.create(username: 'oliver', password: 'pass', home_mountain: 'Turoa')

	end

	def wipe_peeps
		Peep.delete_all
	end
end

require_relative '../shredditors'
