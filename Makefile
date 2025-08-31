install:
	bin/setup
	-bin/tapioca gems --verify
	-bin/tapioca annotations
	-bundle exec tapioca dsl --verify

console:
	bin/console

test:
	bundle exec rake test

lint:
	bundle exec rubocop -A

lint-fix:
	bundle exec rubocop -x

release:
	bundle exec rake release

.PHONY: test
