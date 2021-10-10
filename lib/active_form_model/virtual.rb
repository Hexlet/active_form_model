# frozen_string_literal: true

module ActiveFormModel
  module Virtual
    def self.included(base)
      base.extend Permittable::ClassMethods
      base.extend ClassMethods
      base.prepend Permittable::Prepended
      base.include Permittable
      base.include ActiveModel::Model
    end

    module ClassMethods
      def fields(*attrs)
        send(:attr_accessor, *attrs)
        super(attrs)
      end
    end
  end
end
