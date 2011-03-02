class User < ActiveRecord::Base

  include Verifiable::Associations
  has_many_verifiable :phone_numbers

end
