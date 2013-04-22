A old project started for reddit.com/r/snowboarding.

Lets users of snowboarding reddit (shreddit) create a profile to share pics, home 
mountain location and other mountains they've visited and plan to visit. 

It's not complete and had to be put on hold due to time constraints from other commitments.

Built with Ruby, Sinatra, MongoDb via Mongoid, minitest/spec, coffeescript, bootstrap, jquery masonry and iCanHaz templates.

Initially designed to be hosted on Heroku. Since then, DigitalOcean has released cheap self managed VMs so would prefer to use that. 


##TODO:
- Add backbonejs 
- Replace simple auth with OAuth login via reddit API using OmniAuth gem 
- File uploads to Amazon S3 using paperclip-s3 gem
- Efficient passing of location markers to google maps
- Chef deployment
