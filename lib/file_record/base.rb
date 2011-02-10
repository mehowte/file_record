module FileRecord
  class Base

    def self.model_name
      to_s
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
      persisted? ? to_key.join('-') : false
    end

    
  end
  
end
