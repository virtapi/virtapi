require '../../sources/virtapi_app.rb'

class InitializeVirt < ActiveRecord::Migration
  def up
    create_table :virt_methods do |t|
      t.timestamps null: false
      t.string :name
    end

    create_table :virt_nodes do |t|
      t.timestamps null: false
      t.integer :local_storage_gb
      t.string :vg_name
      t.string :local_storage_path
    end

    create_table :node_method do |t|
      t.timestamps null: false
      t.belongs_to :virt_node, index: true
      t.belongs_to :virt_method, index: true
    end
  end
end

InitializeVirt.migrate(ARGV[0])
