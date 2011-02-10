require 'test_helper'


class Address < FileRecord::Base
  fields :street, :house_number

  validates :street, :house_number, :presence => true
  validates :house_number, :numericality => true
end

class FileRecordTest < ActiveSupport::TestCase
  
  include ActiveModel::Lint::Tests

  def setup
    @model = Address.new
    @model.street = "Florianska"
    @model.house_number = 18
  end

  test "model with proper fields is valid" do
    assert @model.valid?
  end

  test "model without street in invalid" do
    @model.street = nil
    assert !@model.valid?
  end

  test "model without number is invalid" do
    @model.house_number = nil
    assert !@model.valid?
  end

  test "model with invalid number is invalid" do
    @model.house_number = "not number"
    assert !@model.valid?
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
