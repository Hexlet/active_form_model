# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'minitest-power_assert'
require 'active_support/concern'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/module/delegation'
require 'action_controller/metal/strong_parameters'
require 'active_model'

require 'active_form_model'

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each { |file| require file }

require 'minitest/autorun'
