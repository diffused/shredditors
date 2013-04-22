require 'minitest/spec'
require_relative './test_helper'

include Rack::Test::Methods

#def app() Shredditors end

describe "shredditors" do
	def app
    Sinatra::Application
  end

	before do
		test_data = Setup.new
		test_data.wipe_peeps
		test_data.create_peeps
	end

	# it 'homepage says hello' do
	# 	get '/'
	# 	assert_equal "Hello", last_response.body
	# end

	it 'peeps_limit is 2' do
		app.settings.peeps_limit.must_equal 2
	end
	
	it 'peeps list returns correct default data' do
		get '/peeps/list'
		response = JSON.parse(last_response.body)
		response.length.must_equal app.settings.peeps_limit
		response[0]['username'].must_equal 'diffused'
		response[1]['username'].must_equal 'revert'
	end

	it 'peeps list returns correct from page' do
		get '/peeps/list?from=1'
		response = JSON.parse(last_response.body)		
		response[0]['username'].must_equal 'James'
		response[1]['username'].must_equal 'name with spaces'
	end

	it 'peeps list handles bad from page' do
		get '/peeps/list?from=999'
		response = JSON.parse(last_response.body)
		response.length.must_equal 0

		get '/peeps/list?from=-999'
		last_response.status.must_equal 500

		#default handling is convert the 'from' value to 0
		get '/peeps/list?from=bad'		
		response = JSON.parse(last_response.body)
		response.length.must_equal app.settings.peeps_limit
		response[0]['username'].must_equal 'diffused'
		response[1]['username'].must_equal 'revert'
	end

	it 'peeps list does not expose peep password or validation_pass' do
		get '/peeps/list'
		response = JSON.parse(last_response.body)		
		
		response[0]['password'].must_be_nil
		response[0]['validation_pass'].must_be_nil
		
		response[1]['password'].must_be_nil
		response[1]['validation_pass'].must_be_nil
	end

end