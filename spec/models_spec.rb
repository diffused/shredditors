require 'minitest/autorun'
require 'minitest/spec'

require_relative '../models'

Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db('shredditors_test')
end

describe Peep do
	before do
		Peep.delete_all
	end

	after do
		Peep.delete_all
	end

	it 'creates slug on make_slug' do
		peep = Peep.new
		peep.username = "name with spaces"

		slug = peep.make_slug(peep.username)

		slug.must_equal "name_with_spaces"
	end

	it 'create makes entry in peeps collection' do
		Peep.create(username:'diffused', password: 'pass', validation_pass: 'val pass')

		peep = Peep.where(username: 'diffused').first

		peep.username.must_equal 'diffused'
		peep.password.must_equal 'pass'
		peep.validation_pass.must_equal 'val pass'
		peep.location.must_equal [0,0]
	end

	it 'create requires username and password' do
		Peep.create()
		Peep.all.length.must_equal 0

		Peep.create(username: nil)
		Peep.all.length.must_equal 0

		Peep.create(username: '')
		Peep.all.length.must_equal 0

		Peep.create(username: nil, password: nil)
		Peep.all.length.must_equal 0

		Peep.create(username: '', password: nil)
		Peep.all.length.must_equal 0

		Peep.create(username: nil, password: '')
		Peep.all.length.must_equal 0

		Peep.create(username: '', password: '')
		Peep.all.length.must_equal 0
	end

	it 'assigns pics to a peep' do
		peep = Peep.create(username:'diffused', password: 'pass')

		peep.pics.create(filename: "file1.jpg", caption: 'caption 1 here')

		test_peep = Peep.where(username: 'diffused').first
		test_peep.pics.first.filename.must_equal 'file1.jpg'
		test_peep.pics.first.caption.must_equal 'caption 1 here'
	end

	it 'default_pic is /images/thumb_placeholder_1.png' do
		peep = Peep.create(username:'diffused', password: 'pass')
		peep.default_pic.must_equal '/images/thumb_placeholder_1.png'
	end
end


# describe Pic do
# 	before(:each) do
# 		Pic.delete_all
# 	end

# 	after(:each) do
# 		Pic.delete_all
# 	end

# 	it "create makes entry in pics collection" do
# 		Pic.create(filename: "pic.jpg", caption: "some caption")

# 		test_pic = Pic.where(filename: "pic.jpg").first
# 		test_pic.filename.must_equal "pic.jpg"
# 		test_pic.caption.must_equal "some caption"
# 	end

# 	it "create requires filename" do
# 		Pic.create()
# 		Pic.all.length.must_equal 0

# 		Pic.create(filename: '')
# 		Pic.all.length.must_equal 0

# 		Pic.create(filename: nil)
# 		Pic.all.length.must_equal 0
# 	end
# end



