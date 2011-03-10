class Ringtone < ActiveRecord::Base

  include Verifiable::Associations
  has_many_verifiable :phone_numbers
  verifiable_for :users

end
