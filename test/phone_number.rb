class PhoneNumber < ActiveRecord::Base

  include Verifiable::Associations
  verifiable_for :users
  verifiable_for :ringtones

end
