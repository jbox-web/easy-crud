module EasyCRUD
  module Extensions
    module CrudAccessors
      extend ActiveSupport::Concern

      private


        def _crud_new_object
          _crud_model.klass.new
        end


        def _crud_new_scoped_object
          _crud_scoped_association.new
        end


        def _crud_scoped_association
          if _crud_model.polymorphic?
            @polymorphic_object.send(_crud_model.plural_name)
          else
            _crud_scoped_object.send(_crud_model.plural_name)
          end
        end


        def _crud_model_key
          _crud_model.singular_name.to_sym
        end


        def _crud_scoped_key
          if _crud_model.polymorphic?
            _crud_model.polymorphic_name
          else
            _crud_model.scoped_to.singular_name.to_sym
          end
        end


        def _crud_object
          instance_variable_get("@#{_crud_model.singular_name}")
        end


        def _crud_scoped_object
          if _crud_model.polymorphic?
            @polymorphic_object
          else
            instance_variable_get("@#{_crud_model.scoped_to.singular_name}")
          end
        end


        def crud_options
          self._crud_model.options.inspect
        end


        def crud_index_path_for_object
          send(path_for_crud_object(_crud_model.plural_name))
        end


        def crud_index_path_for_scoped_object
          send(path_for_crud_object(_crud_model.scoped_to.plural_name))
        end


        def crud_show_path_for_scoped_object
          if _crud_model.polymorphic?
            send(path_for_crud_object(@polymorphic_key), _crud_scoped_object)
          else
            send(path_for_crud_object(_crud_model.scoped_to.singular_name), _crud_scoped_object)
          end
        end


        def crud_show_path_for_object
          if _crud_model.scoped?
            send(path_for_crud_object("#{_crud_model.scoped_to.singular_name}_#{_crud_model.singular_name}"), _crud_scoped_object, _crud_object)
          elsif _crud_model.polymorphic?
            send(path_for_crud_object(@polymorphic_key), _crud_scoped_object)
          else
            send(path_for_crud_object(_crud_model.singular_name), _crud_object)
          end
        end


        def path_for_crud_object(object)
          "#{_crud_model.namespace}#{object}_path"
        end

    end
  end
end
