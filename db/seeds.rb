# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a = User.new(username: 'admin', email: 'timboh256@gmail.com')
u = User.new(username: 'user', email: 'timboh56@gmail.com')

a.password = 'changeme'
a.password_confirmation = 'changeme'
u.password = 'changeme'
u.password_confirmation = 'changeme'
u.save!(validate: true)
a.save!(validate: true)

admin = Role.find_by_name('admin')
user = Role.find_by_name('user')

a.roles << admin
u.roles << user

a.save!
u.save!
