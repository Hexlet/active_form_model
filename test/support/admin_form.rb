# frozen_string_literal: true

class AdminForm < User
  include ActiveFormModel
  permit :valid_attribute
end
