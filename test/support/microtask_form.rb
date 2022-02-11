# frozen_string_literal: true

class MicrotaskForm < Microtask
  include ActiveFormModel

  permit :valid_attribute
end
