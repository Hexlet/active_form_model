# frozen_string_literal: true

class UnsafeUserForm < UserForm
  permit :invalid_attribute
end
