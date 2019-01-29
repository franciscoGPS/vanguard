# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'ffaker'
Role.create( name: "Admin")


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
  when "development", "test"


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
                1.upto(20) do |ind|

                    sale = Sale.create(season: "2017-2018",
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
                                      quality: [1..5].sample,
                                      box_number: rand(200..2000),
                                      count_type_id: count_type_id_array_from_product.sample
                                      )
                    end # end del upto del shipment
                end # del upto de sales



                Sale.all.each do |sale|
                  driver =  "#{FFaker::NameMX.first_name}"
                  total_pallets = 0
                  sale.shipments.each_with_index do |shipment, index|
                      total_pallets += shipment.pallets_number
                  end

                  sale.customers.each do |customer|

                    Manifest.create(sale_id: sale.id,
                                    date: Time.now,
                                    carrier: "#{FFaker::Company.name}",
                                    driver: driver,
                                    truck: "#{FFaker::Address.building_number}",
                                    truck_licence_plate: "#{FFaker::AddressAU.building_number}",
                                    trailer_num: "#{FFaker::Address.building_number}",
                                    trailer_num_lp: "#{FFaker::AddressAU.building_number}",
                                    stamp: "#{FFaker::Identification.drivers_license}",
                                    thermograph: "#{FFaker::Vehicle.vin}",
                                    po_number: sale.shipments.first.po_number,
                                    delivery_person: "#{FFaker::NameMX.first_name}",
                                    person_receiving: driver,
                                    ship_number: sale.ship_number,
                                    trailer_size: [40,45,50,55,60 ].sample,
                                    caat: "#{FFaker::PhoneNumberDE.mobile_prefix}",
                                    alpha: "#{FFaker::PhoneNumberDE.mobile_prefix}",
                                    fda_num: "#{FFaker::PhoneNumberDE.home_work_phone_number}",
                                    comments: "#{FFaker::HealthcareIpsum.paragraph}",
                                    sold_to: customer.business_name,
                                    sold_to_id: customer.id,
                                    total_pallets: total_pallets,
                                    manifest_number: sale.ship_number,
                                    mex_custom_broker: CustomBroker.where(greenhouse_id: sale.greenhouse_id).where(:country_code => 'MEX').sample.id,
                                    usa_custom_broker: CustomBroker.where(greenhouse_id: sale.greenhouse_id).where(:country_code => 'USA').sample.id,
                                    warehouse_id: Warehouse.where(greenhouse_id: sale.greenhouse_id).sample.id,
                                    custom_invoice_id: greenhouse.next_custom_invoice_id,
                                    leyend: "#{FFaker::HealthcareIpsum.phrase}",
                                    show_color: "#{FFaker::Boolean.random}",
                                    show_count_type: "#{FFaker::Boolean.random}",
                                    show_pkg_type: "#{FFaker::Boolean.random}",
                                    show_bag_type: "#{FFaker::Boolean.random}",
                                    show_plu: "#{FFaker::Boolean.random}" )
                    end

                end



          end#end del greenhouse create
        end# del if de greenhouse


when "production"

end




