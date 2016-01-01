class Storage < ActiveRecord::Base

  has_one :storage_type
  has_one :cache_option

end
