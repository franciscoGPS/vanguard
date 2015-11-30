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
#User.create(name: "Admin", job: "Systems", password: 'Agave15', email: 'hola@agaveti.com', admin: true)
#User.create(name: "Vanguard", job: "Vanguard Admin", password: 'Prueba123!', email: 'diana.s@vanguardco.com.mx', admin: true, role_id: 1)


User.create!([
  {email: "hola@agaveti.com", password: "testadminuser",  reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-02-06 14:02:10", last_sign_in_at: "2015-02-06 14:02:10", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", admin: true, role_id: 1},
  {email: "diana.s@vanguardco.com.mx", password: "testuseraccount",  reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-02-06 14:03:01", last_sign_in_at: "2015-02-06 14:03:01", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", admin: false, role_id: 1},
  {email: "testcustomer@customer.co.uk", password: "testcustomeruser", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-02-06 14:03:44", last_sign_in_at: "2015-02-06 14:03:44", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", admin: false, role_id: 1}
])


# Sets superadmin attribute
x = User.find_by(:email => "hola@agaveti.com")
x.update(superadmin: true)
x.save
#connection = ActiveRecord::Base.connection()
#connection.execute("INSERT INTO bag_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');
#					INSERT INTO package_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');
#					INSERT INTO box_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');
#					INSERT INTO pallet_types(name, created_at, updated_at) VALUES ('GRANDE', '#{Date.today}', '#{Date.today}');")
