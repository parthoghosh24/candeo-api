# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if !User.exists?(username:"anonymous")
	anon_params={}
	anon_params[:name]="Anonymous"	
	anon_params[:email]="anonymous@candeoapp.com"
	User.register(anon_params)
end

