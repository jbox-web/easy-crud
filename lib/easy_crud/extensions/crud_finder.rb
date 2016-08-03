module EasyCRUD
  module Extensions
    module CrudFinder
      extend ActiveSupport::Concern

      included do
        before_action :find_crud_collection, only: :index
        before_action :find_crud_objects
        before_action :set_page_title
        before_action :set_breadcrumb
      end


      private


        def find_crud_objects
          find_crud_scoped_object if _crud_model.scoped?
          find_crud_scoped_polymorphic_object if _crud_model.polymorphic?
          return find_crud_object if _crud_model.find_except_on.any? && !_crud_model.find_except_on.include?(action_name.to_sym)
          return find_crud_object if _crud_model.find_only_on.any? && _crud_model.find_only_on.include?(action_name.to_sym)
        end


        def find_crud_object
          object =
            if _crud_model.scoped?
              _crud_scoped_association.find(find_params)
            elsif _crud_model.polymorphic?
              @polymorphic_object.send(_crud_model.plural_name).find(find_params)
            else
              if finder_includes.empty?
                _crud_model.klass.find(find_params)
              else
                _crud_model.klass.includes(finder_includes).find(find_params)
              end
            end
          instance_variable_set("@#{_crud_model.singular_name}", object)
        rescue ActiveRecord::RecordNotFound => e
          render_404
        end


        def find_crud_scoped_object
          param  = "#{_crud_model.scoped_to.singular_name}_id".to_sym
          object = _crud_model.scoped_to.klass.find(params[param])
          instance_variable_set("@#{_crud_model.scoped_to.singular_name}", object)
        rescue ActiveRecord::RecordNotFound => e
          render_404
        end


        def find_crud_scoped_polymorphic_object
          _crud_model.polymorphic_associations.each do |object|
            param  = "#{object.singular_name}_id".to_sym
            if params[param]
              find_crud_polymorphic_object(object, params[param])
              break
            else
              next
            end
          end
        end


        def find_params
          params[:id]
        end


        def find_crud_polymorphic_object(scoped, id)
          object = scoped.klass.find(id)
          instance_variable_set("@#{scoped.singular_name}", object)
          @polymorphic_key    = scoped.singular_name
          @polymorphic_object = object
        rescue ActiveRecord::RecordNotFound => e
          render_404
        end


        def find_crud_collection
          instance_variable_set("@#{_crud_model.plural_name}", _crud_model.klass.all)
        end


        def finder_includes
          []
        end

    end
  end
end
