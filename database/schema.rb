# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 6) do

  create_table "cache_options", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.string   "description"
  end

  create_table "ceph_mon_nodes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "node_id"
  end

  add_index "ceph_mon_nodes", ["node_id"], name: "index_ceph_mon_nodes_on_node_id"

  create_table "ceph_osd_nodes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "node_id"
  end

  add_index "ceph_osd_nodes", ["node_id"], name: "index_ceph_osd_nodes_on_node_id"

  create_table "ceph_pool", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "domain_states", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.string   "description"
  end

  create_table "domains", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "domain_state_id"
    t.integer  "node_method_id"
    t.integer  "cores"
    t.integer  "ram"
    t.integer  "customer_id"
    t.integer  "cputime_limit"
    t.string   "uuid"
    t.string   "location"
  end

  add_index "domains", ["domain_state_id"], name: "index_domains_on_domain_state_id"
  add_index "domains", ["node_method_id"], name: "index_domains_on_node_method_id"

  create_table "interfaces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "node_id"
    t.integer  "domain_id"
    t.string   "mac"
  end

  add_index "interfaces", ["domain_id"], name: "index_interfaces_on_domain_id"
  add_index "interfaces", ["mac"], name: "index_interfaces_on_mac", unique: true
  add_index "interfaces", ["node_id"], name: "index_interfaces_on_node_id"

  create_table "ipv4s", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "interface_id"
    t.string   "ip"
  end

  add_index "ipv4s", ["interface_id"], name: "index_ipv4s_on_interface_id"
  add_index "ipv4s", ["ip"], name: "index_ipv4s_on_ip", unique: true

  create_table "ipv6s", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "interface_id"
    t.string   "ip"
  end

  add_index "ipv6s", ["interface_id"], name: "index_ipv6s_on_interface_id"
  add_index "ipv6s", ["ip"], name: "index_ipv6s_on_ip", unique: true

  create_table "node_methods", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "virt_node_id"
    t.integer  "virt_method_id"
  end

  add_index "node_methods", ["virt_method_id"], name: "index_node_methods_on_virt_method_id"
  add_index "node_methods", ["virt_node_id"], name: "index_node_methods_on_virt_node_id"

  create_table "node_states", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.string   "description"
  end

  create_table "nodes", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "node_state_id"
    t.string   "fqdn"
    t.string   "location"
  end

  add_index "nodes", ["node_state_id"], name: "index_nodes_on_node_state_id"

  create_table "storage_ceph", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "ceph_pool_id"
    t.boolean  "discard"
  end

  add_index "storage_ceph", ["ceph_pool_id"], name: "index_storage_ceph_on_ceph_pool_id"

  create_table "storage_types", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.string   "description"
  end

  create_table "storages", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "domain_id"
    t.integer  "storage_type_id"
    t.integer  "cache_option_id"
    t.integer  "size"
    t.integer  "write_iops_limit"
    t.integer  "read_ioops_limit"
    t.integer  "write_bps_limit"
    t.integer  "read_bps_limit"
  end

  add_index "storages", ["cache_option_id"], name: "index_storages_on_cache_option_id"
  add_index "storages", ["domain_id"], name: "index_storages_on_domain_id"
  add_index "storages", ["storage_type_id"], name: "index_storages_on_storage_type_id"

  create_table "virt_methods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "virt_nodes", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "node_id"
    t.integer  "local_storage_gb"
    t.string   "vg_name"
    t.string   "local_storage_path"
  end

  add_index "virt_nodes", ["node_id"], name: "index_virt_nodes_on_node_id"

  create_table "vlans", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "interface_id"
    t.integer  "tag"
  end

  add_index "vlans", ["interface_id"], name: "index_vlans_on_interface_id"
  add_index "vlans", ["tag"], name: "index_vlans_on_tag", unique: true

end
