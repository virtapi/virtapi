class Interface < ActiveRecord::Base

  has_many :ipv4s
  has_many :ipv6s
  has_many :vlans

  belongs_to :node
  belongs_to :domain
end
