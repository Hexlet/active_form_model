# frozen_string_literal: true

module ActiveFormModel
  module Permittable
    module Prepended
      def initialize(attrs = {})
        permitted_attrs = permit_attrs(attrs)
        super(permitted_attrs)
      end
    end

    module ClassMethods
      def fields(*args)
        @_permitted_args = args
      end

      def permit(*args)
        @_permitted_args = args
      end

      def _permitted_args
        @_permitted_args || (superclass.respond_to?(:_permitted_args) && superclass._permitted_args) || []
      end
    end

    def update(attrs = {})
      permitted_attrs = permit_attrs(attrs)
      super(permitted_attrs)
    end

    def update!(attrs = {})
      permitted_attrs = permit_attrs(attrs)
      super(permitted_attrs)
    end

    def assign_attributes(attrs = {})
      permitted_attrs = permit_attrs(attrs)
      super(permitted_attrs)
    end

    private

    def permit_attrs(attrs)
      attrs.respond_to?(:permit) ? attrs.send(:permit, self.class._permitted_args) : attrs
    end
  end
end
