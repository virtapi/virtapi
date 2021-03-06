class VirtNode < ActiveRecord::Base
  has_many :node_methods
  has_many :virt_methods, through: :node_methods
  has_many :domains, through: :node_methods
  belongs_to :node
end
