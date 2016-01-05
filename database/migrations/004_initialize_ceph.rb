require '../../sources/virtapi_app.rb'

class InitializeStorage < ActiveRecord::Migration

	def up
		create_table :ceph_osd_nodes do |t|
      t.timestamps null: false
      t.belongs_to :node, index: true
		end

    create_table :ceph_mon_nodes do |t|
      t.timestamps null: false
      t.belongs_to :node, index: true
    end

    create_table :storage_ceph do |t|
      t.timestamps null: false
      t.belongs_to :ceph_pool, index: true
      t.boolean :discard
    end

    create_table :ceph_pool do |t|
      t.timestamps null: false
      t.string :name
    end
		puts 'ran up method'
	end
end

InitializeStorage.migrate(ARGV[0])
