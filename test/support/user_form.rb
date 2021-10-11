# frozen_string_literal: true

class UserForm < User
  include ActiveFormModel
  fields :valid_attribute
end
