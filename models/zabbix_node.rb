class ZabbixNode < ActiveRecord::Base
  include ZabbixHelper
  belongs_to :node
end
