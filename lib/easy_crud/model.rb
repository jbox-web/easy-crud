module EasyCRUD
  module Model
    extend ActiveSupport::Concern

    included do
      class_attribute :model_icon_name

      class << self
        def model_icon(icon)
          self.model_icon_name = icon
        end
      end
    end

  end
end
