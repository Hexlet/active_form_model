# frozen_string_literal: true

require 'active_model'
require 'active_model/attributes'
require 'active_model/attributes/normalization'

module ActiveFormModel
  module Virtual
    extend ActiveSupport::Concern

    include Permittable
    include ActiveModel::API
    include ActiveModel::Attributes
    include ActiveModel::Attributes::Normalization

    class_methods do
      def fields(*attrs)
        permit(*attrs)

        if respond_to?(:attribute)
          attrs.each { |attr| attribute(attr, :string) }
        else
          send(:attr_accessor, *attrs)
        end
      end
    end
  end
end
