module FileRecord
  module AttributeMethods
    module Dirty
      extend ActiveSupport::Concern

      include ActiveModel::Dirty

      def save
        if status = super
          @previously_changed = changes
          @changed_attributes.clear
        end
        status
      end

      def attribute=(name, value)
        attribute_will_change!(name) if attributes[name] != value
        super(name, value)
      end
    end
  end
end
