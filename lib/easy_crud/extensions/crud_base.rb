module EasyCRUD
  module Extensions
    module CrudBase
      extend ActiveSupport::Concern

      def index
      end


      def show
      end


      def new
        render_modal_box(locals: locals_for_new)
      end


      def create
      end


      def edit
        render_modal_box(locals: locals_for_edit)
      end


      def update
      end


      def destroy
      end


      private


        def locals_for_new
          if _crud_model.scoped? || _crud_model.polymorphic?
            { _crud_model_key => _crud_new_scoped_object, _crud_scoped_key => _crud_scoped_object }
          else
            { _crud_model_key => _crud_new_object }
          end
        end


        def locals_for_edit
          if _crud_model.scoped? || _crud_model.polymorphic?
            { _crud_model_key => _crud_object, _crud_scoped_key => _crud_scoped_object }
          else
            { _crud_model_key => _crud_object }
          end
        end


        def default_redirect_url
          if _crud_model.scoped? || _crud_model.polymorphic?
            crud_show_path_for_scoped_object
          else
            crud_show_path_for_object
          end
        end


        def redirect_url_on_success_create(opts = {})
          if _crud_model.scoped? || _crud_model.polymorphic?
            crud_show_path_for_scoped_object
          else
            send(path_for_crud_object(_crud_model.singular_name), opts[_crud_model_key])
          end
        end


        def redirect_url_on_failure_create(opts = {})
          if _crud_model.scoped? || _crud_model.polymorphic?
            crud_show_path_for_scoped_object
          else
            crud_index_path_for_object
          end
        end


        def redirect_url_on_success_destroy(opts = {})
          if _crud_model.scoped? || _crud_model.polymorphic?
            crud_show_path_for_scoped_object
          else
            crud_index_path_for_object
          end
        end


        def redirect_url_on_failure_destroy(opts = {})
          if _crud_model.scoped? || _crud_model.polymorphic?
            crud_show_path_for_scoped_object
          else
            crud_index_path_for_object
          end
        end

    end
  end
end
