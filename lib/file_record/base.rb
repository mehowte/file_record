module FileRecord
  class Base

    extend ActiveModel::Naming
    include ActiveModel::Validations
    extend ActiveModel::Translation
    include ActiveModel::AttributeMethods
    include ActiveModel::Serializers::JSON
    include ActiveModel::Dirty

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

    fields :name
    validates :name, :presence => true

    # include ActiveModel::Conversion
    def to_model
      self
    end

    def persisted?
      name && File.exists?(name)
    end

    def save
      if valid?
        @previously_changed = changes
        @changed_attributes.clear
        File.open(name, 'w') {|f| f.write(to_json) } 
        true
      else
        false
      end
    end

    def destroy
      File.delete(name) if persisted?
    end

    def self.find(name)
      if File.exists? name
        self.new.from_json(File.read(name))
      else
        nil 
      end
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
      attribute_will_change!(name) if @attributes[name] != value
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
