module EasyCRUD
  module Extensions
    module CrudModel
      extend ActiveSupport::Concern

      included do
        class_attribute :_crud_model

        class << self

          def crudify(model_name, opts = {})
            self._crud_model = EasyCRUD.build_crud_model(model_name, opts)
          end

        end
      end

    end
  end
end
