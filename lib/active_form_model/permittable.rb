# frozen_string_literal: true

require 'active_support/deprecation/reporting'

module ActiveFormModel
  module Permittable
    extend ActiveSupport::Concern

    prepended do
      def initialize(attrs = {})
        permitted_attrs = permit_attrs(attrs)
        super(permitted_attrs)
      end
    end

    class_methods do
      def fields(*args)
        @_permitted_args = args
      end

      def permit(*args)
        ActiveSupport::Deprecation.warn('permit is deprecated in favor of fields')
        @_permitted_args = args
      end

      def _permitted_args
        @_permitted_args || (superclass.respond_to?(:_permitted_args) && superclass._permitted_args) || []
      end
    end

    included do
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
end
