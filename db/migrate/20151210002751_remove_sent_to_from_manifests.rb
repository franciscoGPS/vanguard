class RemoveSentToFromManifests < ActiveRecord::Migration
  def change
    remove_column :manifests, :sent_to, :string
  end
end
