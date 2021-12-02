# frozen_string_literal: true

require_relative 'lib/lbd_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'lbd_sdk'
  spec.version       = LbdSdk::VERSION
  spec.authors       = ['YuheiNakasaka']
  spec.email         = ['yuhei.nakasaka@gmail.com']

  spec.summary       = 'Unofficial LINE Blockchain Developer SDK for Ruby'
  spec.description   = 'LINE Blockchain Developer SDK for Ruby. This SDK is not official LINE SDK.'
  spec.homepage      = 'https://github.com/YuheiNakasaka/lbd_sdk_rb'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/YuheiNakasaka/lbd_sdk_rb'
  spec.metadata['changelog_uri'] = 'https://github.com/YuheiNakasaka/lbd_sdk_rb/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
