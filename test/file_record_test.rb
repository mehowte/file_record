require 'test_helper'


class Address < FileRecord::Base
  def initialize(attributes ={})
    super(attributes)
  end
  attributes :street, :house_number

  validates :street, :house_number, :presence => true
  validates :house_number, :numericality => true

  before_save :before_save_callback
  after_save :after_save_callback
  before_destroy :before_destroy_callback
  after_destroy :after_destroy_callback
  attr_reader :callback_info
  def before_save_callback
    @callback_info = "#{@callback_info}a"
  end
  def after_save_callback
    @callback_info = "#{@callback_info}b"
  end
  def before_destroy_callback
    @callback_info = "#{@callback_info}c"
  end
  def after_destroy_callback
    @callback_info = "#{@callback_info}d"
  end
end

class FileRecordTest < ActiveSupport::TestCase
  
  include ActiveModel::Lint::Tests

  def setup
    @model = Address.new
    @model.street = "Florianska"
    @model.house_number = 18
    @model.id = "pauza"
  end

  def teardown
    File.delete("test/dummy/tmp/file_records/pauza") if File.exists?("test/dummy/tmp/file_records/pauza")
  end

  test "runs callbacks" do
    x = Address.create({'id' => "kot", 'street' => "Psia", 'house_number' => 4})
    x.destroy
    assert x.callback_info == "abcd"
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
    @model.clear_id
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
    assert @model.is_street_valid?
    assert @model.is_house_number_valid?

    @model.street = nil

    assert !@model.valid?
    assert !@model.is_street_valid?
    assert @model.is_house_number_valid?
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

  test "ignores not defined attributes" do
    @model.update_attributes({:wrong => "anything"})
    assert @model.attributes[:wrong] == nil
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
