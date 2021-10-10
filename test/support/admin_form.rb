# frozen_string_literal: true

class AdminForm < User
  include ActiveFormModel
  fields :valid_attribute
end
