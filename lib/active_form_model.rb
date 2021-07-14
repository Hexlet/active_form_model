# frozen_string_literal: true

require 'active_form_model/version'
require 'active_support/concern'

module ActiveFormModel
  class Error < StandardError; end

  extend ActiveSupport::Concern

  included do
    prepend Included
    # raise superclass.inspect
    # parent.extend ActiveModel::Naming
  end

  module Included
    def initialize(attrs = {})
      permitted_attrs = permit_attrs(attrs)
      super(permitted_attrs)
    end
  end

  module ClassMethods
    delegate :sti_name, to: :superclass
    delegate :human_attribute_name, to: :superclass
    # NOTE: too many side effects if it is enabled
    # examples: form names, translations
    # delegate :name, to: :superclass

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

  def permit_attrs(attrs)
    attrs.respond_to?(:permit) ? attrs.send(:permit, self.class._permitted_args) : attrs
  end
end
