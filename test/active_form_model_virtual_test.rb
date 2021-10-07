# frozen_string_literal: true

require 'test_helper'

class ActiveFormModelVirtualTest < Minitest::Test
  def setup
    @data = { email: 'Test@test.com', password: 'test', name: 'Jopa' }
    @params = ActionController::Parameters.new(@data)
  end

  def test_it_works
    form = SignInForm.new(@params)

    assert { form.email == @data[:email].downcase }
    assert { form.password == @data[:password] }
    assert_raises(Exception) { form.name }
  end
end
