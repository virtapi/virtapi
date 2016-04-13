class PuppetNode < ActiveRecord::Base
  include PuppetdbHelper
  belongs_to :node
end
