# frozen_string_literal: true

require_relative "lib/credo/detector/version"

Gem::Specification.new do |spec|
  spec.name = "credo-detector"
  spec.version = Credo::Detector::VERSION
  spec.authors = ["Krzysztof Hasiński", "Justyna Wojtczak"]
  spec.email = ["krzysztof.hasinski@gmail.com", "justine84@gmail.com"]

  spec.summary = "Credo detector"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = "https://rubygems.org/gems/credo-detector"
  spec.metadata["source_code_uri"] = "https://github.com/khasinski/credo-detector"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/grab_frame_ext/extconf.rb"]

  spec.required_ruby_version = '>= 2.7'

  spec.add_development_dependency "rake-compiler", "~> 1.0"
  spec.add_development_dependency "pkg-config"
  spec.add_dependency "rmagick"
end
