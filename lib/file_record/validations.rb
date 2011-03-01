module FileRecord
  module Validations
    extend ActiveSupport::Concern
    include ActiveModel::Validations
    include FileRecord::Persistence

    def save
      if valid?
        super
        true
      else
        false
      end
    end
  end
end
