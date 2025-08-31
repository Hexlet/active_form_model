# frozen_string_literal: true

module ActiveFormModel
  module Virtual
    extend ActiveSupport::Concern

    include Permittable
    include ActiveModel::API

    class_methods do
      def fields(*attrs)
        send(:attr_accessor, *attrs)
        permit(*attrs)
      end
    end
  end
end
