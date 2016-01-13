class VirtMethod < ActiveRecord::Base

  has_many :node_methods
  has_many :virt_nodes, through: :node_methods

end
