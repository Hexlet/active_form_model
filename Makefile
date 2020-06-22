install:
	bin/setup

console:
	bin/console

test:
	bundle exec rake test

release:
	bundle exec rake release

.PHONY: test
