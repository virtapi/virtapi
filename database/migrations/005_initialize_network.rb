require '../../sources/virtapi_app.rb'

class InitializeNetwork < ActiveRecord::Migration

	def up
		create_table :interfaces do |t|
      t.timestamps null: false
      t.belongs_to :node, index: true
      t.belongs_to :domain, index: true
      t.string :mac
		end
    add_index :interfaces, :mac, :unique => true

    create_table :ipv6s do |t|
      t.timestamps null: false
      t.belongs_to :interface, index: true
      t.string :ip
    end
    add_index :ipv6s, :ip, :unique => true

    create_table :ipv4s do |t|
      t.timestamps null: false
      t.belongs_to :interface, index: true
      t.boolean :discard
    end
    add_index :ipv4s, :ip, :unique => true

    create_table :vlans do |t|
      t.timestamps null: false
      t.belongs_to :interface, index: true
      t.integer :tag
    end
    add_index :vlans, :tag, :unique => true

		puts 'ran up method'
	end
end

InitializeNetwork.migrate(ARGV[0])
