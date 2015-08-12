class ActiveRecord::Base
  private
  # Assigns attributes, dealing nicely with both multi and single paramater attributes
  # Assumes attributes is a hash

  def assign_attributes(attributes={})
    multiparameter_attributes = []

    attributes.each do |k, v|
      if k.to_s.include?("(")
        multiparameter_attributes << [ k, v ]
      else
        respond_to?(:"#{k}=") || protected_methods.include?(:"#{k}=") ? send(:"#{k}=", v) : raise(ActiveRecord::UnknownAttributeError, "unknown attribute: #{k}")
      end
    end

    assign_multiparameter_attributes(multiparameter_attributes) unless  multiparameter_attributes.empty?
  end
end
