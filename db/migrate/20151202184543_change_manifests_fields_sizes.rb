class ChangeManifestsFieldsSizes < ActiveRecord::Migration
    def up


      change_column :manifests, :carrier, :string
      change_column :manifests, :driver, :string
      change_column :manifests, :truck, :string
      change_column :manifests, :truck_licence_plate, :string
      change_column :manifests, :trailer_num, :string
      change_column :manifests, :trailer_num_lp, :string
      change_column :manifests, :stamp, :string
      change_column :manifests, :thermograph, :string
      change_column :manifests, :delivery_person, :string
      change_column :manifests, :person_receiving, :string
      change_column :manifests, :caat, :string
      change_column :manifests, :alpha, :string
      change_column :manifests, :fda_num, :string
      change_column :manifests, :sold_to, :string



    end

    def down

      change_column :manifests, :carrier, :string, limit: 200
      change_column :manifests, :driver, :string, limit: 80
      change_column :manifests, :truck, :string, limit: 15
      change_column :manifests, :truck_licence_plate, :string, limit: 15
      change_column :manifests, :trailer_num, :string, limit: 15
      change_column :manifests, :trailer_num_lp, :string, limit: 15
      change_column :manifests, :stamp, :string, limit: 40
      change_column :manifests, :thermograph, :string, limit: 15
      change_column :manifests, :delivery_person, :string, limit: 80
      change_column :manifests, :person_receiving, :string, limit: 80
      change_column :manifests, :caat, :string, limit: 6
      change_column :manifests, :alpha, :string, limit: 15
      change_column :manifests, :fda_num, :string, limit: 20
      change_column :manifests, :sold_to, :string, limit: 150



    end

end
