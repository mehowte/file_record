module FileRecord
  class Base

    extend ActiveModel::Naming
    include ActiveModel::Validations
    extend ActiveModel::Translation

    def self.fields(*args)
      attr_accessor(*args)
    end

    # include ActiveModel::Conversion
    def to_model
      self
    end

    def persisted?
      false
    end

    def to_key
      persisted? ? [id] : nil
    end

    def to_param
      persisted? ? to_key.join('-') : nil
    end

    
  end
  
end
