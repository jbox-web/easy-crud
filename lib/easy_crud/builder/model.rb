module EasyCRUD
  module Builder
    class Model

      attr_reader :name
      attr_reader :options
      attr_reader :parent
      attr_reader :polymorphic
      attr_reader :crumbs_opts


      def initialize(name, opts = {})
        @name        = name
        @options     = EasyCRUD.default_options.deep_merge(opts)
        @parent      = @options.delete(:parent) { nil }
        @polymorphic = @options.delete(:polymorphic) { [] }
        @crumbable   = @options[:crumbable]
        @crumbs_opts = @options[:crumbs_opts]
      end


      def crumbable?
        @crumbable
      end


      def scoped?
        !scoped_to.nil?
      end


      def polymorphic_name
        @options[:polymorphic_name]
      end


      def polymorphic?
        !polymorphic.empty?
      end


      def polymorphic_associations
        @polymorphic_associations ||= []
        polymorphic.each do |model|
          @polymorphic_associations << EasyCRUD::Builder::Model.new(model, options)
        end
        @polymorphic_associations
      end


      def scoped_to
        return nil if parent.nil?
        @scoped_to ||= EasyCRUD::Builder::Model.new(parent, options)
      end


      def klass
        @klass ||= class_name.constantize
      end


      def class_name
        "#{name.to_s.camelize.gsub('/', '::')}".gsub('::::', '::')
      end


      def this_class
        klass.base_class
      end


      def singular_name
        ActiveModel::Naming.param_key(this_class)
      end


      def plural_name
        singular_name.pluralize
      end


      def namespace
        !options[:namespace].nil? ? "#{options[:namespace]}_" : ''
      end


      def find_only_on
        options[:find][:only]
      end


      def find_except_on
        options[:find][:except]
      end


      def params(type)
        { singular_name.to_sym => options[:params][type] }
      end

    end
  end
end
