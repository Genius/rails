String.prepend(Module.new do
  %i(start_with? starts_with? end_with? ends_with?).each do |method|
    module_eval <<-CODE, __FILE__, __LINE__ + 1
    def #{method}(*args)
      a = args.select { |a| a.is_a?(String) || a.respond_to?(:to_str) }
      a.empty? ? false : super(*a)
    end
    CODE
  end
end)
