module FileRecord
  module Compatibility
    extend ActiveSupport::Concern

    included do    
      extend ActiveModel::Naming
      extend ActiveModel::Translation
      include ActiveModel::Conversion
    end
  end
end
