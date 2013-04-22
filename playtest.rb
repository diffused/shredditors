require './models'

Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("shredditors")
end

def wipe_data
	#Pic.delete_all
	Peep.delete_all
end

@test_home_mountains = [
	'Jackson Hole', 'Mayrhofen', 'Whakapapa', 'Turoa', 'Coronet Peak', 'Niseko',
	'Kicking Horse', 'Whistler', 'Red', 'Grindelwald', 'Lake Louise', 'Panorama',
	'Les Deux Alpes', 'Alp de Huez', 'Zermatt'
]

def create_lots_of_peeps
	100.times do |i|
		Peep.create(
			username: "peep_#{i}", 
			password: 'pass', 			
			home_mountain: @test_home_mountains[rand(0...@test_home_mountains.length)],
			default_pic: "/images/thumb_placeholder_#{i%3+1}.png")
		 
		add_pic("peep_#{i}", "/images/thumb_placeholder_#{i%3+1}.png", 
		"caption for peep #{i}")
	end
end

def create_peeps 
	Peep.create(username: 'diffused', password: 'pass', home_mountain: 'Turoa')
	add_pic('diffused', 'diffused1.jpg', 'diffused was here')
	
	Peep.create(username: 'revert', password: 'pass', home_mountain: 'Turoa')
	add_pic('revert', 'revert1.jpg')

	Peep.create(username: 'James', password: 'pass', home_mountain: 'Turoa')	
	add_pic('James', '/images/nil.jpg')

	Peep.create(username: 'blah blah Yo', password: 'pass', home_mountain: 'Jackson Hole')
	add_pic('James', '/images/nil.jpg')
end



def add_pic(username, filename, caption = nil)
	peep = Peep.where(username: username).first
	#puts peep._id

	peep.pics.create(filename: filename, caption: caption)

	#pic = Pic.create(filename: filename)	
	#peep.pics << pic
	#peep.save

	
end


def auth_peep(username, password) 
	Peep.exists?(conditions: { 'username' => username, 'password' => password } )
end

#puts auth_peep('diffused', 'pass')



# add_pic('diffused', 'r1.jpg')
# add_pic('diffused', 'r2.jpg')

# peeps = PeepLite.all.without(:password)

# peeps.each do |p|
# 	puts p.username		
# 	#puts p.password
# end

# wipe_data

#peep = Peep.where(username: 'diffused').first
#puts peep

wipe_data
create_peeps
create_lots_of_peeps

# 100.times do |i|
# 	puts test_home_mountains[rand(0...test_home_mountains.length)]
# end



# add_pic('diffused', 'toomuchsnow.png')
# add_pic('revert', "revert.jpg")
# add_pic('James', "james.jpg")


# PeepLite.all.each do |peep|
# 	puts peep
# 	#puts peep.make_slug(peep.username)

# 	# peep.pics.each do |pic|
# 	# 	puts "\t#{pic}"
# 	# end
# end

# r = Random.new(1123)
# puts r.integer(10)

#puts rand(0..test_home_mountains.length)

# Peep.create(username: "test", password: nil, validation_pass: 'blah')

# puts Peep.all.length


# 1.upto(100) do |i|
	
# 	if i % 5 == 0 and i % 3 == 0
# 		puts "#{i}\tFizzBuzz"
# 	elsif i % 5 == 0
# 		puts "#{i}\tBuzz"
# 	elsif i %3 == 0
# 		puts "#{i}\tFizz"
# 	else 
# 		puts i
# 	end	
		
# end


