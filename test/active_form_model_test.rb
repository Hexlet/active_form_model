# frozen_string_literal: true

require 'test_helper'

class ActiveFormModelTest < Minitest::Test
  def setup
    @data = { valid_attribute: :one, invalid_attribute: :two }
    @params = ActionController::Parameters.new(@data)
  end

  def test_permitted_attrs_for_new
    @form = UserForm.new(@params)
    assert { @form.invalid_attribute.nil? }
    assert { @form.valid_attribute == :one }
  end

  def test_permitted_attrs_for_update
    @form = UserForm.new
    @form.update(@params)
    assert { @form.invalid_attribute.nil? }
    assert { @form.valid_attribute == :one }
  end

  def test_permitted_attrs_for_assign_attributes
    @form = UserForm.new
    @form.assign_attributes(@params)
    assert { @form.invalid_attribute.nil? }
    assert { @form.valid_attribute == :one }
  end

  # def test_permitted_attrs_for_update!
  #   @form = UserForm.new
  #   @form.update!(@params)
  #   assert { @form.invalid_attribute.nil? }
  #   assert { @form.valid_attribute == :one }
  # end
  #
  # TODO: add test for sti_name
  # TODO: add test for human_attribute_name
end
