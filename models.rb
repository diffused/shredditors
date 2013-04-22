require 'mongoid'

module ModelHelpers 
	def make_slug(title)
		title.downcase.gsub(/ /, '_').gsub(/[^a-z0-9_]/, '').squeeze('_')
	end
end


class Peep
	include Mongoid::Document
	include ModelHelpers

	validates_presence_of :username, :password	

	field :username
	field :username_slug
	field :password
	field :default_pic, default: '/images/thumb_placeholder_1.png'
	field :validation_pass
	field :home_mountain
	field :home_mountain_slug
	field :short_message
	field :location, type: Array, default: [0,0]
	
	embeds_many :pics
	
	before_create :generate_username_slug, :generate_home_mountain_slug
	before_update :generate_home_mountain_slug

	def to_s
		"#{username}, #{username_slug}, #{_id}, #{home_mountain}, #{home_mountain_slug} #{short_message}"
	end

	protected
	def generate_username_slug
		self.username_slug = make_slug(username)
		

	end

	def generate_home_mountain_slug
		if self.home_mountain != nil then			
			self.home_mountain_slug = make_slug(home_mountain)
		end
	end
end

class Pic
	include Mongoid::Document
	
	validates_presence_of :filename

	field :filename
	field :caption

	embedded_in :peep

	def to_s
		"#{filename}"
	end
end


