module FileRecord
  module AttributeMethods
    module All
      extend ActiveSupport::Concern
      include Read
      include Write
      include Validation
      include Dirty
    end
  end
end
