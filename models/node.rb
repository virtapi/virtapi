class Node < ActiveRecord::Base
  has_many :interfaces
  has_many :ipv4s, through: :interfaces
  has_many :ipv6s, through: :interfaces
  has_many :vlans, through: :interfaces
  belongs_to :node_state
end
