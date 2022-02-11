# frozen_string_literal: true

require 'active_support/deprecation'

module ActiveFormModel
  module Permittable
    extend ActiveSupport::Concern

    included do
      prepend Prepended
    end

    module Prepended
      def initialize(attrs = {})
        permitted_attrs = permit_attrs(attrs)
        super(permitted_attrs)
      end
    end

    class_methods do
      def permit(*args)
        @_permitted_args = args
      end

      alias_method :fields, :permit
      deprecate fields: :permit, deprecator: ActiveSupport::Deprecation.new('0.6.0', 'ActiveFormModel')

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
