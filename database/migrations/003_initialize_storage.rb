require_relative '../../sources/virtapi_app.rb'

class InitializeStorage < ActiveRecord::Migration
  def up
    create_table :storages do |t|
      t.timestamps null: false
      t.belongs_to :domain, index: true
      t.belongs_to :storage_type, index: true
      t.belongs_to :cache_option, index: true
      t.integer :size
      t.integer :write_iops_limit
      t.integer :read_ioops_limit
      t.integer :write_bps_limit
      t.integer :read_bps_limit
    end

    create_table :cache_options do |t|
      t.timestamps null: false
      t.string :name
      t.string :description
    end

    create_table :storage_types do |t|
      t.timestamps null: false
      t.string :name
      t.string :description
    end
  end
end

InitializeStorage.migrate(ARGV[0])
