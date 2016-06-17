# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


Role.create( name: "Admin")

User.create(name: "Admin",
            job: "Systems",
            email: "hola@agaveti.com",
            password: ".Agave15!",
            admin: true,
            role_id: 1, #Admin
            superadmin: true)
User.create(name: "Diana Saenz",
            job: "Admin Vanguard",
            email: "diana.s@vanguardco.com.mx",
            password: "Prueba123!",
            admin: true,
            role_id: 1)

DeliveryPlace.create(name: "McAllen, Tx.")
DeliveryPlace.create(name: "Houston, Tx.")


