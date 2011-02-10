require 'test_helper'


class Address < FileRecord::Base
  fields :street, :house_number
end

class FileRecordTest < ActiveSupport::TestCase
  
  include ActiveModel::Lint::Tests

  def setup
    @model = Address.new
  end

  test "Addres is proper kind" do
    assert_kind_of FileRecord::Base, @model 
  end

  test "Fields are added properly" do
    assert @model.respond_to?(:street) 
    assert @model.respond_to?(:street=) 
    assert @model.respond_to?(:house_number) 
    assert @model.respond_to?(:house_number=) 
  end
end
