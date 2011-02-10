module FileRecord
  class Base

    extend ActiveModel::Naming
    include ActiveModel::Validations
    extend ActiveModel::Translation
    include ActiveModel::AttributeMethods
    include ActiveModel::Serializers::JSON
    include ActiveModel::Dirty

    def initialize(attributes = {})
      @attributes = attributes
    end

    def self.create(attributes = {})
      obj = self.new(attributes)
      obj.save ? obj : nil
    end

    def update_attributes(attributes)
      @attributes.merge!(attributes)
      save
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
      name && File.exists?(self.class.filename(name))
    end

    def save
      if valid?
        @previously_changed = changes
        @changed_attributes.clear
        File.open(self.class.filename(name), 'w') {|f| f.write(to_json) } 
        true
      else
        false
      end
    end

    def destroy
      File.delete(self.class.filename(name)) if persisted?
    end

    def self.find(name)
      if File.exists? filename(name)
        self.new.from_json(File.read(filename(name)))
      else
        nil 
      end
    end

    def self.all
      Dir.new("tmp/file_records").entries.reject do |name|
        File.directory?(name)  
      end.map do |name|
        find(name)
      end
    end

    def to_key
      persisted? ? [name] : nil
    end

    def to_param
      persisted? ? to_key.join('-') : nil
    end

    def self.filename(name)
      "tmp/file_records/" + name
    end
  protected

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
