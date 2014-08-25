# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:name=>'Jason Hobbs', :email=>'grimmstede@feemon.com', :password=>'Testing1', :admin=>true)
User.create(:name=>'Test User', :email=>'test@feemon.com', :password=>'Testing1', :admin=>false)
Group.create(:name=>'community', :user_id=>'1')
