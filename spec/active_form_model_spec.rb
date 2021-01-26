# frozen_string_literal: true

RSpec.describe ActiveFormModel do
  class User
    include(ActiveModel::Model)

    attr_accessor(:valid_attribute, :invalid_attribute)

    def update(*args)
      assign_attributes(*args)
      true
    end
  end

  class UserForm < User
    include(ActiveFormModel)

    permit(:valid_attribute)
  end

  let(:valid_value) { "foo" }
  let(:invalid_value) { "bar" }
  let(:valid_initial_value) { "qux" }
  let(:invalid_initial_value) { "quz" }

  let(:mixed_hash_params) do
    {
      valid_attribute: valid_value,
      invalid_attribute: invalid_value
    }
  end

  let(:mixed_strong_params) do
    ActionController::Parameters.new(mixed_hash_params)
  end

  let(:form) do
    UserForm.new(
      valid_attribute: valid_initial_value,
      invalid_attribute: invalid_initial_value
    )
  end

  it("has a version number") { expect(::ActiveFormModel::VERSION).not_to be_nil }

  it("accepts mixed hash params for constructor") do
    expect(valid_initial_value).to eq(form.valid_attribute)
    expect(invalid_initial_value).to eq(form.invalid_attribute)
  end

  it("accepts mixed strong params for constructor") do
    form = UserForm.new(mixed_strong_params)

    expect(valid_value).to eq(form.valid_attribute)
    if mixed_strong_params.respond_to?(:permit)
      expect(form.invalid_attribute).to be_nil
    else
      expect(invalid_value).to eq(form.invalid_attribute)
    end
  end

  it("accepts mixed hash params for assignment") do
    form.assign_attributes(mixed_hash_params)

    expect(valid_value).to eq(form.valid_attribute)
    expect(invalid_value).to eq(form.invalid_attribute)
  end

  it("accepts mixed strong params for assignment") do
    form.assign_attributes(mixed_strong_params)
    expect(valid_value).to eq(form.valid_attribute)

    if mixed_strong_params.respond_to?(:permit)
      expect(invalid_initial_value).to eq(form.invalid_attribute)
    else
      expect(invalid_value).to eq(form.invalid_attribute)
    end
  end

  it("accepts mixed hash params for update") do
    form.update(mixed_hash_params)

    expect(valid_value).to eq(form.valid_attribute)
    expect(invalid_value).to eq(form.invalid_attribute)
  end

  it("accepts mixed strong params for update") do
    form.update(mixed_strong_params)
    expect(valid_value).to eq(form.valid_attribute)

    if mixed_strong_params.respond_to?(:permit)
      expect(invalid_initial_value).to eq(form.invalid_attribute)
    else
      expect(invalid_value).to eq(form.invalid_attribute)
    end
  end
end
