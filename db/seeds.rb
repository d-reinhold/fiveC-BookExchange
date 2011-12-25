# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


dom = User.create!(:name => 'Dominick Reinhold', :email => 'dfr12009@pomona.edu', :password => 'foobar', :password_confirmation => 'foobar')
dom.listings.create!(:title => "The Hitchhiker's Guide to the Galaxy", :author => "Douglas Adams", :isbn => Random.rand(0000000000000..9999999999999), :price_dollars => Random.rand(1..1000), :price_cents => Random.rand(0..99), :condition => ['New','Lightly Used', 'Heavily Used', 'Falling Apart'].shuffle.first, :description => Faker::Lorem.sentence )
  
