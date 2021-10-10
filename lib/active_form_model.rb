# frozen_string_literal: true

require 'active_form_model/version'
require 'active_support/concern'
require 'active_form_model/permittable'

module ActiveFormModel
  autoload :Virtual, 'active_form_model/virtual'

  class Error < StandardError; end

  extend ActiveSupport::Concern

  def self.included(base)
    base.extend Permittable::ClassMethods
    base.prepend Permittable::Prepended
    base.include Permittable
  end

  module ClassMethods
    delegate :sti_name, to: :superclass
    delegate :human_attribute_name, to: :superclass

    # NOTE: too many side effects if it is enabled
    # examples: form names, translations
    # delegate :name, to: :superclass
  end
end
