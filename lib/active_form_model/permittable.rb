# frozen_string_literal: true

require 'active_support/deprecation'

module ActiveFormModel
  module Permittable
    extend ActiveSupport::Concern

    class_methods do
      def new(attrs = nil, &block)
        attrs = _permit_attrs(attrs) if attrs

        super(attrs, &block)
      end

      def permit(*args)
        @_permitted_args = args
      end

      alias_method :fields, :permit
      deprecate fields: :permit, deprecator: ActiveSupport::Deprecation.new('0.6.0', 'ActiveFormModel')

      def _permitted_args
        @_permitted_args || (superclass.respond_to?(:_permitted_args) && superclass._permitted_args) || []
      end

      def _permit_attrs(attrs)
        attrs.respond_to?(:permit) ? attrs.send(:permit, _permitted_args) : attrs
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
      self.class._permit_attrs(attrs)
    end
  end
end
