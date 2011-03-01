module FileRecord
  module AttributeMethods
    module Validation
      extend ActiveSupport::Concern
      include ActiveModel::AttributeMethods

      included do
        attribute_method_suffix "_valid?"
      end

      protected
      def attribute_valid?(attribute)
        valid? || errors[attribute].empty?
      end
    end
  end
end
