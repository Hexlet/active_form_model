# frozen_string_literal: true

class User
  include ActiveModel::Model
  attr_accessor :valid_attribute, :invalid_attribute, :locale

  def update(*args)
    assign_attributes(*args)
    true
  end

  def initialize(attrs = nil)
    defaults = {
      locale: :en
    }

    attrs_with_defaults = attrs ? defaults.merge(attrs) : defaults
    super(attrs_with_defaults)
  end
end
