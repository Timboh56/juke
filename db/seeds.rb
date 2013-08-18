# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new(username: 'admin1', email: 'timboh256@gmail.com')
u.password = 'changeme'
u.password_confirmation = 'changeme'
u.save!(validate: true)

admin = Role.find_by_name('admin')

u.roles << admin

u.save!