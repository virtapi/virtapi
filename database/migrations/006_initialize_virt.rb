require '../../sources/virtapi_app.rb'

class InitializeVirt < ActiveRecord::Migration

	def up
		create_table :virt_methods do |t|
      t.string :name
		end

    create_table :virt_nodes do |t|
      t.integer :local_storage_gb
      t.string :vg_name
      t.string :local_storage_path
    end

    create_table :node_method do |t|
      t.belongs_to :virt_node, index: true
      t.belongs_to :virt_method, index: true
    end

		puts 'ran up method'
	end
end

InitializeVirt.migrate(ARGV[0])
