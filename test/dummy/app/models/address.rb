class Address < FileRecord::Base
    def initialize(attributes = {})
      super(attributes)
    end

  attributes :street, :house_number

  validates :street, :house_number, :presence => true
  validates :house_number, :numericality => true
end
