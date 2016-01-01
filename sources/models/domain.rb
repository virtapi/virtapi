class Domain < ActiveRecord::Base
  
  has_many :interface
  has_many :storage
  has_one :domain_state

end
