module FileRecord
  module AttributeManagement
    extend ActiveSupport::Concern

    included do
      class_attribute :_attribute_names 
      self._attribute_names = []

      attr_reader :attributes
    end

    def attributes=(attributes)
      @attributes = attributes
      sanitize_attributes

    end

    def sanitize_attributes
      @attributes.keep_if do |name, value| 
        self.class._attribute_names.include? name.to_sym
      end
    end

    module ClassMethods
      def attributes(*attribute_names)
        self._attribute_names += attribute_names
        self._attribute_names.uniq!
      end
    end

  end
end
