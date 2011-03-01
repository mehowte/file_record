module FileRecord
  class Base
    extend ActiveModel::Naming
    include ActiveModel::Validations
    extend ActiveModel::Translation
    include FileRecord::AttributeManagement
    include FileRecord::Persistence

    def initialize(attributes = {})
      self.attributes = attributes 
    end



    #include ActiveModel::Conversion

    def to_model
      self
    end

    def to_key
      persisted? ? [id] : nil
    end

    def to_param
      persisted? ? to_key.join('-') : nil
    end

  end

  Base.class_eval do
    include FileRecord::AttributeMethods::Read
    include FileRecord::AttributeMethods::Validation
    include FileRecord::AttributeMethods::Dirty
    attributes :id
    validates :id, :presence => true
  end
end

