# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'ffaker'
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

Greenhouse.public_activity_off
Product.public_activity_off
Sale.public_activity_off
Customer.public_activity_off

if DeliveryPlace.all.count == 0
  DeliveryPlace.create(name: "McAllen, Tx.")
  DeliveryPlace.create(name: "Houston, Tx.")
end

def seed_greenhouse
    FactoryGirl.create(:greenhouse)
end

def seed_product
    product = FactoryGirl.build(:product, id: Product.maximum(:id).to_i.next)
    product.save!
end


case Rails.env
  when "development"


  if (PackageType.all.count == 0)
    1.upto(6) do |i|
      PackageType.create(name: "Package-#{FFaker::Product.model }"  )
    end
  end # end del if

  if (BoxType.all.count == 0)
    1.upto(6) do |i|
      BoxType.create(name: "Box-#{FFaker::Product.model }"  )
    end
  end # end del if

  if (PalletType.all.count == 0)
    1.upto(6) do |i|
      PalletType.create(name: "Pallet-#{FFaker::Product.model }"  )
    end
  end # end del if

  if (BagType.all.count == 0)
    1.upto(6) do |i|
      BagType.create(name:  "Bag-#{FFaker::Product.model }"  )
    end
  end # end del if


        ship_number = 1

        if Greenhouse.all.count == 0
            1.upto(10) do |gh|
              greenhouse =  Greenhouse.create(
                  business_name:  "#{ FFaker::Company.name }",
                  fiscal_address:  "#{ FFaker::Address.street_address }",
                  greenhouse_address:  "#{ FFaker::Address.street_address }",
                  rfc:  "#{ FFaker::Internet.password(10)}",
                  category:  "#{ FFaker::DizzleIpsum.word}",
                  fda_num:  "#{ FFaker::SSNMX.issste}",
                  color: "\#%06x" % (rand * 0xffffff)
              )

              1.upto(5) do |i|
                  Customer.create(business_name: "#{ FFaker::Company.name }",
                  billing_address: "#{ FFaker::Address.street_address }",
                  shipping_address: "#{ FFaker::Address.street_address }",
                  tax_id_number: "#{ FFaker::SSNMX.issste}",
                  chep_id_number: "#{ FFaker::SSN.ssn}",
                  bb_number: "#{ FFaker::Vehicle.vin}",
                  greenhouse_id: greenhouse.id
                  )

      end #end del customer create

              1.upto(5) do |i|
                Color.create(name: "#{FFaker::Color.name}",
                    greenhouse_id: greenhouse.id )
              end

              1.upto(10) do |i|
                    product = Product.create(
                    name:  "#{ FFaker::Product.product }",
                    greenhouse_id: greenhouse.id,
                    active: true,
                    brand:  "#{ FFaker::Product.brand }",
                    description: "#{ FFaker::HipsterIpsum.paragraph }"
                    )

                1.upto(6) do |i|
                  CountType.create(name: "conteo #{i} #{product.name}",
                                   product_id: product.id )
                end


              end#end del Product

              1.upto(5) do |i|
                        Warehouse.create(name:  "#{ FFaker::Company.name }",
                        greenhouse_id: greenhouse.id,
                        address: "#{ FFaker::Address.street_address }",
                        tax_id: "#{ FFaker::SSNMX.issste}",
                        phone: "#{ FFaker::PhoneNumberMX.international_phone_number}")
              end# end del wh create

              1.upto(3) do |i|
                CustomBroker.create(name:  "#{ FFaker::Company.name }",
                        greenhouse_id: greenhouse.id,
                        address: "#{ FFaker::Address.street_address }",
                        country_code: "MEX")
              end

              1.upto(3) do |i|
                CustomBroker.create(name:  "#{ FFaker::Company.name }",
                        greenhouse_id: greenhouse.id,
                        address: "#{ FFaker::Address.street_address }",
                        country_code: "USA")
              end




                warehouse_id_array = Warehouse.where(greenhouse_id: greenhouse.id).order(:id).map{|p| p.id}
                delivery_place_id_array = DeliveryPlace.all.order(:id).map{|p| p.id}
                1.upto(10) do |ind|

                    sale = Sale.create(season: "2016-2017",
                            departure_date: Time.now.advance(:days => +1),
                            arrival_date: Time.now.advance(:days => +2),
                            annotation: "#{FFaker::HipsterIpsum.sentences}",
                            comment: "#{FFaker::HipsterIpsum.sentences}",
                            user_id: 1,
                            ship_number: gh.to_s+""+(ind-1).to_s,
                            greenhouse_id: greenhouse.id,
                            warehouse_id: warehouse_id_array.sample,
                            delivery_place_id: delivery_place_id_array.sample
                            )



                    prods_id_array = Product.where(greenhouse_id: greenhouse.id).order(:id).map{|p| p.id}
                    customer_id_array = Customer.where(greenhouse_id: greenhouse.id).order(:id).map{|p| p.id}
                    colors_id_array = Color.where(greenhouse_id: greenhouse.id).order(:id).map{|p| p.id}
                    box_type_id_array = BoxType.order(:id).map{|p| p.id}
                    bag_type_id_array = BagType.order(:id).map{|p| p.id}
                    pallet_type_id_array = PalletType.order(:id).map{|p| p.id}
                    package_type_id_array = PackageType.order(:id).map{|p| p.id}
                    po_number = rand(200000..300000)
                    1.upto(5) do |i|
                      product_id = prods_id_array.sample
                      count_type_id_array_from_product = CountType.where(product_id: product_id).order(:id).map{|p| p.id}
                      Shipment.create(product_id: product_id,
                                      pallets_number: rand(5..20),
                                      comments: "#{FFaker::HipsterIpsum.sentences}",
                                      sale_id: sale.id,
                                      price: rand(10..150),
                                      customer_id: customer_id_array.sample,
                                      weight: [5, 11, 15, 20, 25, 30, 40 ].sample,
                                      product_color: colors_id_array.sample,
                                      box_type_id: box_type_id_array.sample,
                                      bag_type_id: bag_type_id_array.sample,
                                      pallet_type_id: pallet_type_id_array.sample,
                                      package_type_id: package_type_id_array.sample,
                                      po_number: po_number,
                                      quality: 1,
                                      box_number: rand(200..2000),
                                      count_type_id: count_type_id_array_from_product.sample
                                      )
                    end # end del upto del shipment
                end # del upto de sales

          end#end del greenhouse create
       end# del if de greenhouse


when "production"

end




