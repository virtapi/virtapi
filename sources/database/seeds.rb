# ruby encoding: utf-8

require "#{__dir__}/../sources/virtapi_app.rb"

# Create all Cache Options for storage
cache_options = [
  ['default', 'the hypervisor default'],
  ['none', 'nobody knows'],
  ['writethrough', 'do not use the cache'],
  ['writeback', 'use the cache'],
  ['directsync' 'even ignore page cache'],
  ['unsafe', 'cache allll the things, ignore sync() requests']
]
cache_options.each do |option|
  CacheOption.create(name: option[0], description: option[1])
end
# create storage types
# wat?

# create virtualization methods
methods = [
  'KVM',
  'Qemu',
  'Docker',
  'Parallels Cloud Server',
  'Parallels Server Bare Metall',
  'systemd-nspawn'
]
methods.each do |method|
  VirtMethod.create(name: method)
end

# create all node states
state_list = [
  ['stopped', 'node is stopped'],
  ['running', 'node is running'],
  ['deactivated', 'someone disabled this node'],
  ['maintenance' 'there is currently maintenance going on']
]
state_list.each do |state|
  NodeState.create(name: state[0], description: state[1])
end

# create all domain states
state_list = [
  ['stopped', 'domain is stopped'],
  ['running', 'domain is running'],
  ['deactivated', 'an admin disabled this domain'],
  ['maintenance' 'there is currently maintenance on the host system, keep calm']
]
state_list.each do |state|
  DomainState.create(name: state[0], description: state[1])
end

# create all vlans
(0..4095).each do |id|
  Vlan.create(tag: id)
end
