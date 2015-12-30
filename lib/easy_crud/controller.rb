require 'easy_crud/extensions/crud_model'
require 'easy_crud/extensions/crud_accessors'
require 'easy_crud/extensions/crud_base'
require 'easy_crud/extensions/crud_breadcrumbs'
require 'easy_crud/extensions/crud_finder'
require 'easy_crud/extensions/page_title'

module EasyCRUD
  module Controller
    extend ActiveSupport::Concern
    included do
      include EasyCRUD::Extensions::CrudModel
      include EasyCRUD::Extensions::CrudAccessors
      include EasyCRUD::Extensions::CrudBase
      include EasyCRUD::Extensions::CrudBreadcrumbs
      include EasyCRUD::Extensions::CrudFinder
      include EasyCRUD::Extensions::PageTitle
    end
  end
end
