class Storage < ActiveRecord::Base
  belongs_to :storage_type
  belongs_to :cache_option
  belongs_to :domain
end
