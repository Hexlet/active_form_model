# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'minitest-power_assert'
require 'active_support/concern'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/module/delegation'
require 'action_controller/metal/strong_parameters'
require 'active_model'
require 'active_record'

require 'active_form_model'

require_relative 'support/user'
require_relative 'support/user_form'
require_relative 'support/unsafe_user_form'
require_relative 'support/admin'
require_relative 'support/admin_form'
require_relative 'support/sign_in_form'
require_relative 'support/task'
require_relative 'support/microtask'
require_relative 'support/microtask_form'
require_relative 'support/database'

require 'minitest/autorun'
