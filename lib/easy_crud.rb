require 'easy_crud/builder/model'
require 'easy_crud/controller'
require 'easy_crud/model'

module EasyCRUD
  extend self

  def default_options
    {
      namespace:        nil,
      parent:           nil,
      polymorphic:      [],
      polymorphic_name: nil,
      crumbable:        true,
      params: {
        on_create: [],
        on_update: []
      },
      find: {
        only: [],
        except: [:index, :new, :create]
      }
    }.clone
  end


  def build_crud_model(model, opts = {})
    EasyCRUD::Builder::Model.new(model, opts)
  end

end
