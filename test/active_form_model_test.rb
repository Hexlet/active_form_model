# frozen_string_literal: true
require 'test_helper'

class ActiveFormModelTest < MiniTest::Test
  class User
    include ActiveModel::Model
    attr_accessor :valid_attribute, :invalid_attribute

    def update(*args)
      assign_attributes(*args)
      true
    end
  end

  class UserForm < User
    include ActiveFormModel
    permit :valid_attribute
  end

  VALID_VALUE = "foo"
  INVALID_VALUE = "bar"
  VALID_INITIAL_VALUE = "qux"
  INVALID_INITIAL_VALUE = "quz"

  def setup
    @mixed_hash_params = { valid_attribute: VALID_VALUE, invalid_attribute: INVALID_VALUE }
    @mixed_strong_params = ActionController::Parameters.new(@mixed_hash_params)
    @form = UserForm.new(valid_attribute: VALID_INITIAL_VALUE, invalid_attribute: INVALID_INITIAL_VALUE)
  end

  def test_that_it_has_a_version_number
    refute_nil ::ActiveFormModel::VERSION
  end

  def test_it_accepts_mixed_hash_params_for_constructor
    assert_equal @form.valid_attribute, VALID_INITIAL_VALUE
    assert_equal @form.invalid_attribute, INVALID_INITIAL_VALUE
  end

  def test_it_accepts_mixed_strong_params_for_constructor
    @form = UserForm.new(@mixed_strong_params)

    assert_equal @form.valid_attribute, VALID_VALUE

    if @mixed_strong_params.respond_to?(:permit)
      assert_nil @form.invalid_attribute
    else
      assert_equal @form.invalid_attribute, INVALID_VALUE
    end
  end

  def test_it_accepts_mixed_hash_params_for_assignment
    @form.assign_attributes(@mixed_hash_params)

    assert_equal @form.valid_attribute, VALID_VALUE
    assert_equal @form.invalid_attribute, INVALID_VALUE
  end

  def test_it_accepts_mixed_strong_params_for_assignment
    @form.assign_attributes(@mixed_strong_params)

    assert_equal @form.valid_attribute, VALID_VALUE

    if @mixed_strong_params.respond_to?(:permit)
      assert_equal @form.invalid_attribute, INVALID_INITIAL_VALUE
    else
      assert_equal @form.invalid_attribute, INVALID_VALUE
    end
  end

  def test_it_accepts_mixed_hash_params_for_update
    @form.update(@mixed_hash_params)

    assert_equal @form.valid_attribute, VALID_VALUE
    assert_equal @form.invalid_attribute, INVALID_VALUE
  end

  def test_it_accepts_mixed_strong_params_for_update
    @form.update(@mixed_strong_params)

    assert_equal @form.valid_attribute, VALID_VALUE

    if @mixed_strong_params.respond_to?(:permit)
      assert_equal @form.invalid_attribute, INVALID_INITIAL_VALUE
    else
      assert_equal @form.invalid_attribute, INVALID_VALUE
    end
  end
end
