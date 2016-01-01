class Node < ActiveRecord::Base

  has_many :interface
  has_one :node_state

end
