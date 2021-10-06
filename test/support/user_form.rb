# frozen_string_literal: true

class UserForm < User
  include ActiveFormModel
  permit :valid_attribute
end
