# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if !ShowcaseCap.exists?(1)
	ShowcaseCap.create!(quota:2500, end_time:Time.now.to_datetime+7.days, start_time:Time.now.to_datetime+7.days+30.minutes)	
end
