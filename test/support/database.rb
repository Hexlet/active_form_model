# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table 'tasks' do |t|
    t.string 'valid_attribute'
    t.string 'invalid_attribute'
    t.string 'type'
  end
end
