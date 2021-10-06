# frozen_string_literal: true

class User
  include ActiveModel::Model
  attr_accessor :valid_attribute, :invalid_attribute

  def update(*args)
    assign_attributes(*args)
    true
  end
end
