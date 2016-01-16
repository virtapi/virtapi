require_relative '../../virtapi_app.rb'

class InitializeDomain < ActiveRecord::Migration
  def up
    create_table :domains do |t|
      t.timestamps null: false
      t.belongs_to :domain_state, index: true
      t.belongs_to :node_method, index: true
      t.integer :cores
      t.integer :ram
      t.integer :customer_id
      t.integer :cputime_limit
      t.string :uuid
      t.string :location
    end

    create_table :domain_states do |t|
      t.timestamps null: false
      t.string :name
      t.string :description
    end
  end
end

InitializeDomain.migrate(ARGV[0])
