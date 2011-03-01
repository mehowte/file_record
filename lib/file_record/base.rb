module FileRecord
  class Base
    extend ActiveModel::Naming
    extend ActiveModel::Translation
    include ActiveModel::Conversion

    include AttributeManagement
    include Persistence
    include Validations
    include AttributeMethods::All

    attributes :id
    validates :id, :presence => true

    def initialize(attributes = {})
      self.attributes = attributes 
    end
  end
end

