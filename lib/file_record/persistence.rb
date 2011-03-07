module FileRecord
  module Persistence
    extend ActiveSupport::Concern
    include ActiveModel::Serializers::JSON

    module ClassMethods
      def find(name)
        if File.exists? filename(name)
          self.new.from_json(File.read(filename(name)))
        else
          nil 
        end
      end

      def all
        Dir.new(Rails.root + "tmp/file_records").entries.reject do |name|
          File.directory?(name)  
        end.map do |name|
          find(name)
        end
      end
      
    def create(attributes = {})
      obj = self.new(attributes)
      obj.save ? obj : nil
    end

      def filename(name)
        Rails.root + "tmp/file_records/" + name
      end
    end

    def persisted?
      id && File.exists?(self.class.filename(id))
    end


    def save
        File.open(self.class.filename(id), 'w') {|f| f.write(to_json) } 
    end


    def destroy
      File.delete(self.class.filename(id)) if persisted?
    end

    def update_attributes(attributes)
      @attributes.merge!(attributes)
      sanitize_attributes
      save
    end
  end
end
