# frozen_string_literal: true

class UserForm < User
  include ActiveFormModel

  permit :valid_attribute, :file

  skip_if_empty :file
end
