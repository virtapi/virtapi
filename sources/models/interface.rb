class Interface < ActiveRecord::Base

  has_many :ipv4
  has_many :ipv6
  mas_many :vlan

end
