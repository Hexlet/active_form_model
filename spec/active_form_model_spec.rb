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

  describe "#initialize" do
    it "accepts mixed hash params" do
      expect(form).to have_attributes(
        valid_attribute: valid_initial_value,
        invalid_attribute: invalid_initial_value
      )
    end

    it "accepts mixed strong params" do
      form = UserForm.new(mixed_strong_params)

      expect(form).to have_attributes(
        valid_attribute: valid_value,
        invalid_attribute: nil
      )
    end
  end

  describe '#assign_attributes' do
    it "accepts mixed hash params" do
      form.assign_attributes(mixed_hash_params)

      expect(form).to have_attributes(
        valid_attribute: valid_value,
        invalid_attribute: invalid_value
      )
    end

    it "accepts mixed strong params" do
      form.assign_attributes(mixed_strong_params)

      expect(form).to have_attributes(
        valid_attribute: valid_value,
        invalid_attribute: invalid_initial_value
      )
    end
  end

  describe '#update' do
    it "accepts mixed hash params" do
      form.update(mixed_hash_params)

      expect(form).to have_attributes(
        valid_attribute: valid_value,
        invalid_attribute: invalid_value
      )
    end

    it "accepts mixed strong params" do
      form.update(mixed_strong_params)

      expect(form).to have_attributes(
        valid_attribute: valid_value,
        invalid_attribute: invalid_initial_value
      )
    end
  end
end
