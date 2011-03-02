require "active_record"

module Verifiable
  class Verification < ActiveRecord::Base

    belongs_to :object, :polymorphic => true
    belongs_to :verifiable, :polymorphic => true

    validates_uniqueness_of :object_id, :scope => [:object_type, :verifiable_id, :verifiable_type]
    validates_presence_of :code

    def initialize(attrs = {})
      super({:code => sprintf("%04d", rand(10000))}.merge(attrs || {}))
    end

    def verified?
      !verified_at.nil?
    end

  end
end
