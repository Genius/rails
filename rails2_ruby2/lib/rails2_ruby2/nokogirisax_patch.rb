ActiveSupport::XmlMini.singleton_class.prepend(Module.new do
  def backend=(name)
    super(name).tap do
      if !name.is_a?(Module) && name.to_s.downcase == 'nokogirisax'
        ActiveSupport::XmlMini_NokogiriSAX::HashBuilder.prepend(Module.new do
          def start_element(name, attrs = [])
            super(name, attrs.flatten)
          end
        end)
      end
    end
  end
end)
