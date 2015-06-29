# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:name=>'Admin', :email=>'test@test.com', :password=>'Testing1', :admin=>true)
User.create(:name=>'Test User', :email=>'test@feemon.com', :password=>'Testing1', :admin=>false)
Group.create(:name=>'community')
Tag.create(:name=>'general', :color=>'general')
Tag.create(:name=>'question', :color=>'secondary')
connection = ActiveRecord::Base.connection()
connection.execute("insert into groupmembers (user_id, group_id) values (1, 1)")
connection.execute("insert into groupmembers (user_id, group_id) values (2, 1)")
