class Interface < ActiveRecord::Base
  # TODO: add validation to check that an interface is only owned by a domain OR node
  has_many :ipv4s
  has_many :ipv6s
  has_many :vlans

  belongs_to :node
  belongs_to :domain
end
