class SignInForm
  include ActiveFormModel::Virtual

  properties :email, :password

  validates :email, presence: true
  validates :password, presence: true

  def email=(value)
    @email = value.downcase
  end
end
