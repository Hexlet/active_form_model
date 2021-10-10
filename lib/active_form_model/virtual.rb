# frozen_string_literal: true

module ActiveFormModel
  module Virtual
    def self.included(base)
      base.extend Permitable::ClassMethods
      base.extend ClassMethods
      base.prepend Permitable::Prepended
      base.include Permitable
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
