# frozen_string_literal: true

require 'active_support/concern'

module ActiveFormModel
  module Virtual
    class Error < StandardError; end

    extend ActiveSupport::Concern

    included do
      prepend Included
      include ActiveModel::Model
    end

    module Included
      def initialize(attrs = {})
        super(permit_attrs(attrs))
      end
    end

    module ClassMethods
      def properties(*attrs)
        @_permitted_attrs = attrs
        send(:attr_accessor, *attrs)
      end

      def _permitted_attrs
        @_permitted_attrs || []
      end
    end

    def permit_attrs(attrs)
      attrs.respond_to?(:permit) ? attrs.send(:permit, self.class._permitted_attrs) : attrs
    end
  end
end
