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
Role.create( name: "Admin")
User.create(name: "Admin", job: "Systems", password: 'Agave15', email: 'hola@agaveti.com', admin: true)
User.create(name: "Vanguard", job: "Vanguard Admin", password: 'Prueba123!', email: 'diana.s@vanguardco.com.mx', admin: true, role_id: 1)


# Sets superadmin attribute
x = User.find_by(:email => "hola@agaveti.com")
x.update(superadmin: true)
x.save
#connection = ActiveRecord::Base.connection()
#connection.execute("INSERT INTO bag_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');
#					INSERT INTO package_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');
#					INSERT INTO box_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');
#					INSERT INTO pallet_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');")
