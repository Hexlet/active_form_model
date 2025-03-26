# frozen_string_literal: true

require 'active_support/deprecation'
require 'active_support/core_ext/class/attribute'

module ActiveFormModel
  module Permittable
    extend ActiveSupport::Concern

    included do
      class_attribute(:_permitted_args, instance_predicate: false, default: [])
      class_attribute(:_skipped_args, instance_predicate: false, default: [])
    end

    class_methods do
      def new(attrs = nil, &block)
        attrs = _permit_attrs(attrs) if attrs

        super
      end

      def permit(*args)
        self._permitted_args = _permitted_args | args
      end

      def skip_if_empty(*args)
        self._skipped_args = args
      end

      alias_method :fields, :permit
      deprecate fields: :permit, deprecator: ActiveSupport::Deprecation.new('0.6.0', 'ActiveFormModel')

      def _permit_attrs(attrs)
        permitted = attrs.respond_to?(:permit) ? attrs.send(:permit, _permitted_args) : attrs
        _skipped_args.each do |key|
          value = permitted[key.to_s] || permitted[key.to_sym]
          if value.blank?
            permitted.delete(key.to_s)
            permitted.delete(key.to_sym)
          end
        end

        permitted
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
