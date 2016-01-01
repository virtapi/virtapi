require '../../sources/virtapi_app.rb'

class InitializeNodeTable < ActiveRecord::Migration

	def up
		create_table :nodes do |t|
      t.string :ipv4_addr_ext
      t.string :ipv6_addr_ext
      t.string :ipv4_gw_ext
      t.string :ipv6_gw_ext
      t.string :fqdn
      t.string :location
		end
		puts 'ran up method'
	end
end

InitializeNodeTable.migrate(ARGV[0])
