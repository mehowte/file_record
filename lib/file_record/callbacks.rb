module FileRecord
  module Callbacks
    extend ActiveSupport::Concern
    included do
      extend ActiveModel::Callbacks
      include ActiveModel::Validations::Callbacks

      define_model_callbacks :save, :destroy
    end 


    def save
      run_callbacks(:save) { super }
    end

    def destroy
      run_callbacks(:destroy) { super }
    end
  end
end
