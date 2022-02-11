# frozen_string_literal: true

require 'test_helper'

class ActiveFormModelActiveRecordTest < Minitest::Test
  def setup
    @data = { valid_attribute: 'one', invalid_attribute: 'two' }
    @params = ActionController::Parameters.new(@data)
    ActiveRecord::Base.connection.execute('DELETE FROM tasks;')
  end

  def test_permitted_attrs_for_new
    @form = MicrotaskForm.new(@params)
    assert { @form.invalid_attribute.nil? }
    assert { @form.valid_attribute == 'one' }
  end

  def test_permitted_attrs_for_update
    @form = MicrotaskForm.create
    @form.update(@params)
    assert { @form.invalid_attribute.nil? }
    assert { @form.valid_attribute == 'one' }
  end

  def test_permitted_attrs_for_update!
    @form = MicrotaskForm.create
    @form.update!(@params)
    assert { @form.invalid_attribute.nil? }
    assert { @form.valid_attribute == 'one' }
  end

  def test_permitted_attrs_for_assign_attributes
    @form = MicrotaskForm.new
    @form.assign_attributes(@params)
    assert { @form.invalid_attribute.nil? }
    assert { @form.valid_attribute == 'one' }
  end

  def test_permitted_attrs_for_create
    @form = MicrotaskForm.create(@params)
    assert { @form.invalid_attribute.nil? }
    assert { @form.valid_attribute == 'one' }
  end

  def test_permitted_attrs_for_create_with_block
    @form = MicrotaskForm.create(@params) do |task|
      task.invalid_attribute = 'two'
    end
    assert { @form.invalid_attribute == 'two' }
    assert { @form.valid_attribute == 'one' }
  end

  def test_setting_inheritance_column
    @form = MicrotaskForm.new
    assert { @form.type == 'Microtask' }
  end
end
