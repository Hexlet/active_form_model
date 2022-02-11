# frozen_string_literal: true

require_relative 'lib/active_form_model/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_form_model'
  spec.version       = ActiveFormModel::VERSION
  spec.authors       = ['Kirill']
  spec.email         = ['mokevnin@gmail.com']

  spec.summary       = 'Painless forms for ActiveRecord'
  spec.description   = 'Based on inheritance'
  spec.homepage      = 'https://github.com/Hexlet/active_form_model'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Hexlet/form-model.git'
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('activesupport', '>= 3')

  spec.add_development_dependency('actionpack', '>= 5')
  spec.add_development_dependency('activemodel', '>= 5')
  spec.add_development_dependency('activerecord', '>= 5')
  spec.add_development_dependency('sqlite3')
end
