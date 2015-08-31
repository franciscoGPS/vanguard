# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#
#   Default user
#   Package_type.create([{name: 'chico'},{name: 'mediano'},{name: 'grande'}])
#   Box_type.create([{name: 'chico'},{name: 'mediano'},{name: 'grande'}])
# 	Pallet_type.create([{name: 'chico'},{name: 'mediano'},{name: 'grande'}])
#   Bag_type.create([{name: 'chico'},{name: 'mediano'},{name: 'grande'}])

  User.create( password: '.Agave15!', email: 'hola@agaveti.com', admin: true)


{'chico', 'mediano', 'grande'}.each do |tipo|
	Package_type.create(name: tipo)
	Box_type.create(name: tipo)
	Pallet_type.create(name: tipo)
	Bag_type.create(name: tipo)
end

