module ActiveRecord
  module Associations
    class AssociationProxy
      def send(method, *args)
        if proxy_respond_to?(method, true)
          super
        else
          load_target
          @target.send(method, *args)
        end
      end
    end
  end
end
