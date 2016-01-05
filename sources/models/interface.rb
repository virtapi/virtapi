class Interface < ActiveRecord::Base

  has_many :ipv4
  has_many :ipv6
  has_many :vlan

end
