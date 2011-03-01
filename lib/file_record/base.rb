module FileRecord
  class Base

    include AttributeManagement
    include Persistence
    include Validations
    include Callbacks
    include AttributeMethods::All
    include Compatibility

    attributes :id
    validates :id, :presence => true

    def initialize(attributes = {})
      self.attributes = attributes 
    end
  end
end

