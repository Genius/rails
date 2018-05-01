require 'active_support/core_ext/hash/indifferent_access'

module ActionController
  class ParamsHashWithIndifferentAccess < HashWithIndifferentAccess

    def self.new_from_hash_copying_default(hash)
      new(hash).tap do |new_hash|
        new_hash.default = hash.default
      end
    end

    def with_indifferent_access
      self.class.new_from_hash_copying_default(self)
    end

    # Returns an exact copy of the hash.
    def dup
      # this does not copy defaults,
      # since the HashWithIndifferentAccess in 2.3 does not either
      self.class.new(self)
    end

    def reverse_merge(other_hash)
      self.class.new_from_hash_copying_default(super)
    end

    protected

    def convert_value(value)
      if value.class == Hash || value.class == HashWithIndifferentAccess
        self.class.new_from_hash_copying_default(value)
      elsif value.is_a?(Array)
        value.collect { |e| convert_value(e) }
      else
        value
      end
    end

  end
end


ParamsHashWithIndifferentAccess = ActionController::ParamsHashWithIndifferentAccess
