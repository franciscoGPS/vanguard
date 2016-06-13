class AddGreenhouseToCustomBroker < ActiveRecord::Migration
  def change
    add_reference :custom_brokers, :greenhouse, index: true, foreign_key: true
  end
end
