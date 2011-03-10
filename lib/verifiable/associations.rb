module Verifiable
  module Associations
    def self.included(base)
      base.extend(ClassMethods)
    end

    def verify!(object, code)
      verification = verification_for(object)
      if code == verification.code
        verification.update_attributes(:verified_at => Time.now)
        true
      else
        false
      end
    end

    def verification_code_for(object)
      verification_for(object).code
    end

    def verification_for(object)
      Verification.find(:first, :conditions => {:object_id => object.id, :object_type => object.class.to_s, :verifiable_id => self.id, :verifiable_type => self.class.to_s}) || Verification.find(:first, :conditions => {:object_id => self.id, :object_type => self.class.to_s, :verifiable_id => object.id, :verifiable_type => object.class.to_s})
    end

    module ClassMethods
      def has_many_verifiable(things, options = {})
        source_type = things.to_s.singularize.camelize
        has_many :verifications, :as => :object, :dependent => :destroy, :class_name => "Verifiable::Verification" unless reflect_on_association(:verifications)
        has_many things, :through => :verifications, :source => :verifiable, :source_type => source_type, :conditions => "verified_at IS NOT NULL"
        has_many "unverified_#{things}", :through => :verifications, :source => :verifiable, :source_type => source_type, :conditions => "verified_at IS NULL"
      end

      def verifiable_for(things, options = {})
        thing_name = things.to_s.singularize
        source_type = thing_name.camelize
        reverse_association_name = "#{thing_name}_verifications".to_sym
        has_many reverse_association_name, :as => :verifiable, :dependent => :destroy, :class_name => "Verifiable::Verification"
        has_many things, :through => reverse_association_name, :source => :object, :source_type => source_type, :conditions => "verified_at IS NOT NULL"
        has_many "unverified_#{things}", :through => reverse_association_name, :source => :object, :source_type => source_type, :conditions => "verified_at IS NULL"
      end
    end
  end
end
