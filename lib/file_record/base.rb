module FileRecord
  class Base

    extend ActiveModel::Naming

    def self.fields(*args)

    end

    def valid?
      true
    end

    def errors
      obj = Object.new
      def obj.[](key)         [] end
      def obj.full_messages() [] end
      obj   
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
