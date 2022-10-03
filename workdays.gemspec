# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "workdays/version"

Gem::Specification.new do |spec|
  spec.name          = "workdays"
  spec.version       = Workdays::VERSION
  spec.authors       = ["Humi Payroll Team"]
  spec.email         = ["payroll@humi.ca"]

  spec.summary       = "A hard-working collection of methods to make calculating " \
                       "working dates easier."
  spec.description   = "Provides a number of convenience methods to simplify " \
                       "calculating dates while respecting non-working days. Uses the " \
                       "Holiday gem so that holiday schedules can be localized and " \
                       "customized."
  spec.homepage      = "https://github.com/Humi-HR/workdays"
  spec.license       = "MIT"

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w[LICENSE README.md]
  spec.executables   = spec.files.grep(%r{^bin/})   { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})  { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("activesupport")
  spec.add_dependency("holidays")

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-rspec"
end
