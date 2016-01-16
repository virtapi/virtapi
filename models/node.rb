class Node < ActiveRecord::Base
  has_many :interfaces
  has_many :ipv4s, through: :interfaces
  has_many :ipv6s, through: :interfaces
  has_many :vlans, through: :interfaces
  has_many :node_methods, through: :virt_node
  has_many :virt_methods, through: :virt_node
  has_many :domains, through: :virt_node
  belongs_to :node_state
end
