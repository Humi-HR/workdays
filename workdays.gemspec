# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "workdays/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name          = "workdays"
  spec.version       = Workdays::VERSION
  spec.authors       = ["Julien Roger"]
  spec.email         = ["jroger@abletribe.com"]

  spec.summary       = "A hard-working collection of methods to make calculating " \
                       "working dates easier."
  spec.description   = "Provides a number of convenience methods to simplify " \
                       "calculating dates while respecting non-working days. Uses the " \
                       "Holiday gem so that holiday schedules can be localized and " \
                       "customized."
  spec.homepage      = "https://github.com/julienroger/workdays"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w[LICENSE README.md]
  spec.executables   = spec.files.grep(%r{^bin/})   { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})  { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("activesupport", ">= 4.2.8")
  spec.add_dependency("holidays")

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.6"
  spec.add_development_dependency "rubocop", "~> 0.49"
  spec.add_development_dependency "rubocop-rspec", "~> 1.15"
end
