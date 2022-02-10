# frozen_string_literal: true

class MicrotaskForm < Microtask
  include ActiveFormModel

  fields :valid_attribute
end
