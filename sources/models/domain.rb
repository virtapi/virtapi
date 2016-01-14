class Domain < ActiveRecord::Base
  has_many :interfaces
  has_many :ipv4s, through: :interfaces
  has_many :ipv6s, through: :interfaces
  has_many :vlans, through: :interfaces
  has_many :storages
  has_one :domain_state

  belongs_to :node_method
end
