require 'easy_crud/builder/model'
require 'easy_crud/controller'

module EasyCRUD
  extend self

  def default_options
    {
      namespace:        nil,
      parent:           nil,
      polymorphic:      [],
      polymorphic_name: nil,
      crumbable:        false,
      crumbs_opts:      {},
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
