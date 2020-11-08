# frozen_string_literal: true

module ActiveFormModel
  module Generators
    class FormGenerator < ::Rails::Generators::NamedBase
      class_option :model, type: :string
      source_root File.expand_path('templates', __dir__)

      def create_form
        template 'form.rb', File.join('app/forms', class_path, "#{file_name}_form.rb")
      end
    end
  end
end
