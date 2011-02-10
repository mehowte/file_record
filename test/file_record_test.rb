require 'test_helper'


class Address < FileRecord::Base

end

class FileRecordTest < ActiveSupport::TestCase
  def setup
    @model = Address.new
  end

  test "Addres is proper kind" do
    assert_kind_of FileRecord::Base, @model 
  end
end
