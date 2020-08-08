# frozen_string_literal: true

require_relative 'lib/sem_ver/description'

Gem::Specification.new do |spec|
  spec.name    = SemVer::NAME
  spec.version = SemVer::VERSION
  spec.authors = [SemVer::AUTHORS[0][:name]]
  spec.email   = [SemVer::AUTHORS[0][:email]]

  spec.summary               = SemVer::SUMMARY
  spec.description           = SemVer::DESCRIPTION
  spec.homepage              = SemVer::HOMEPAGE
  spec.license               = SemVer::LICENSE
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://github.com/igortice/sem_ver'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'colorize'
  spec.add_runtime_dependency 'tty-box'
  spec.add_runtime_dependency 'tty-prompt'
  spec.add_runtime_dependency 'tty-screen'
  spec.add_runtime_dependency 'tty-table'
  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
end
