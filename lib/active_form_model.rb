require 'active_form_model/version'

module ActiveFormModel
  class Error < StandardError; end

  extend ActiveSupport::Concern

  included do
    prepend Included
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
    # delegate :name, to: :superclass

    def permit(*args)
      @_permitted_args = args
    end

    def _permitted_args
      @_permitted_args || []
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
