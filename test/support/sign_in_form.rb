# frozen_string_literal: true

class SignInForm
  include ActiveFormModel::Virtual

  fields :email, :password
  normalizes :email, with: ->(value) { value.downcase }

  validates :email, presence: true
  validates :password, presence: true
end
