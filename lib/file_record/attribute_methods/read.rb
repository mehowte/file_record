module FileRecord
  module AttributeMethods
    module Read
      extend ActiveSupport::Concern
      include ActiveModel::AttributeMethods

      included do
        attribute_method_prefix ""
      end
      module ClassMethods
        def attributes(*args)
          super(*args)
          define_attribute_methods args
        end
      end

      protected
      def attribute(name)
        @attributes[name]
      end

    end
  end
end
