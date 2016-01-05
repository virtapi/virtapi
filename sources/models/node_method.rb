class NodeMethod < ActiveRecord::Base

  has_one :domain

  belongs_to :virt_method
  belongs_to :virt_node

end
