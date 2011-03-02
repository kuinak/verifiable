class PhoneNumber < ActiveRecord::Base

  include Verifiable::Associations
  verifiable_for :users

end
