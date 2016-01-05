require '../../sources/virtapi_app.rb'

class InitializeNodeTable < ActiveRecord::Migration

  def up
    create_table :nodes do |t|
      t.timestamps null: false
      t.belongs_to :node_state, index: true
      t.string :fqdn
      t.string :location
		end

    create_table :node_states do |t|
      t.timestamps null: false
      t.string :name
      t.string :description
    end
		puts 'ran up method'
  end
end

InitializeNodeTable.migrate(ARGV[0])
