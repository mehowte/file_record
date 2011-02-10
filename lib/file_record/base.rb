module FileRecord
  class Base

    extend ActiveModel::Naming
    include ActiveModel::Validations
    extend ActiveModel::Translation
    include ActiveModel::AttributeMethods
    include ActiveModel::Serializers::JSON

    def initialize
      @attributes = {}
    end
    attr_reader :attributes

    attribute_method_prefix "clear_"
    attribute_method_prefix ""
    attribute_method_suffix "="
    attribute_method_suffix "_valid?"
    

    def self.fields(*args)
      define_attribute_methods args
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

  private
    def attributes=(attributes)
      @attributes = attributes
    end
    def attribute(name)
      @attributes[name]
    end

    def attribute=(name, value)
      @attributes[name] = value
    end

    def clear_attribute(attribute)
      send(:"#{attribute}=", nil)
    end

    def attribute_valid?(attribute)
      valid? || errors[attribute].empty?
    end

    
  end
  
end
