# frozen_string_literal: true

class SignInForm
  include ActiveFormModel::Virtual

  fields :email, :password

  validates :email, presence: true
  validates :password, presence: true

  def email=(value)
    @email = value.downcase
  end
end
