install:
	bin/setup

console:
	bin/console

test:
	bundle exec rake test

lint:
	bundle exec rubocop -A

release:
	bundle exec rake release

.PHONY: test
