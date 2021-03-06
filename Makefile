.PHONY: clean install test rubocop spec guard

vendor:
	$(info => Installing Ruby dependencies)
	@bundle install --path vendor --with developement --binstubs=vendor/bin

test: vendor rubocop spec

guard: vendor
	$(info => Starting guard)
	@bundle exec guard

rubocop:
	$(info => Running rubocop)
	@vendor/bin/rubocop

spec:
	$(info => Running spec tests)
	@vendor/bin/rspec

pkg:
	$(info => Building gem package in pkg/)
	@mkdir pkg/
	@gem build tfctl.gemspec
	@mv *.gem pkg/

install: pkg
	gem install pkg/*.gem

clean:
	$(info => Cleaning)
	@rm -rf pkg/
	@rm -rf vendor/
	@rm -rf .bundle
	@rm -f Gemfile.lock
	@rm -rf spec/reports/
