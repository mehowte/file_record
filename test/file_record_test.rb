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
    @model.name = "pauza"
  end

  def teardown
    File.delete("tmp/file_records/pauza") if File.exists?("tmp/file_records/pauza")
  end

  test "tracks changes" do
    assert @model.changed?
    assert @model.save
    assert !@model.changed?
    @model.street = "Florianska"
    assert !@model.changed?
    @model.street = "Grodzka"
    assert @model.changed?
    assert !Address.find("pauza").changed?
    @model.reset_street!
    assert @model.street == "Florianska"
    #assert !@model.changed?
  end

  test "can be saved" do
    assert !@model.persisted?
    assert @model.save
    assert @model.persisted?
  end

  test "saved can be found" do
    assert @model.save
    found = Address.find("pauza")
    assert !found.nil?
    assert found.street == @model.street
    assert found.house_number == @model.house_number
  end

  test "requires name" do
    @model.clear_name
    assert !@model.valid?
  end

  test "saved can be destroyed" do
    assert @model.save
    assert @model.destroy
    assert !@model.persisted?
  end

  test "can't find not existing" do
    assert Address.find("nieistniejacy") == nil
  end

  test "cannot be saved when invalid" do
    @model.clear_street
    assert !@model.save
    assert !@model.persisted?
  end

  test "attributes can be cleared" do
    @model.clear_street
    assert @model.street.nil? 
    @model.clear_house_number
    assert @model.clear_house_number.nil? 
  end

  test "attributes can be validated" do
    assert @model.valid?
    assert @model.street_valid?
    assert @model.house_number_valid?

    @model.street = nil

    assert !@model.valid?
    assert !@model.street_valid?
    assert @model.house_number_valid?
  end
 
  test "model with proper fields is valid" do
    assert @model.valid?
  end

  test "can be (de)serialized" do
    json = @model.to_json
    deserialized = Address.new
    deserialized.from_json json
    assert deserialized.street == @model.street
    assert deserialized.house_number == @model.house_number
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

  test "model_name.human uses I18n" do 
    begin
      custom_translations = {
        :activemodel => { 
          :models => { 
            :address => "Translated address" 
          },
          :errors => {
            :messages => {
              :blank => "Translated error"
            }
          }
        } 
      }
      I18n.backend.store_translations :en, custom_translations
      assert_equal "Translated address", @model.class.model_name.human 
      @model.street = nil
      @model.valid?
      assert_equal "Translated error", @model.errors[:street].first 
    ensure
      I18n.reload!
    end 
  end

end
