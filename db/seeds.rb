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
Role.create!( name: "Admin")
User.new(name: "Admin", job: "Systems", password: 'Agave15.', encrypted_password: '$2a$04$N22xaTrL02/dKCUb65FGzOOHrcvoRrgL1uQVSWq/YFPka/Q9nYZY6', email: 'hola@agaveti.com', admin: true).save
User.new(name: "Vanguard", job: "Vanguard Admin", password: 'Prueba123!', encrypted_password: '$2a$04$tJ629HYGiDfpcDYJ3TuAB.iFnADsER2sVqgMR9SgShWIYGUBUawYy', email: 'diana.s@vanguardco.com.mx', admin: true, role_id: 1).save


# Sets superadmin attribute
x = User.find_by(:email => "hola@agaveti.com")
x.update(superadmin: true)
x.save
#connection = ActiveRecord::Base.connection()
#connection.execute("INSERT INTO bag_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');
#					INSERT INTO package_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');
#					INSERT INTO box_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');
#					INSERT INTO pallet_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');")
