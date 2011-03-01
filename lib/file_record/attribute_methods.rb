module FileRecord
  module AttributeMethods
    autoload :Read, 'file_record/attribute_methods/read'
    autoload :Write, 'file_record/attribute_methods/write'
    autoload :Validation, 'file_record/attribute_methods/validation'
    autoload :Dirty, 'file_record/attribute_methods/dirty'
    autoload :All, 'file_record/attribute_methods/all'
  end
  
end
