# frozen_string_literal: true

require_relative "lib/functional_view/version"

Gem::Specification.new do |spec|
  spec.name          = "functional_view"
  spec.version       = FunctionalView::VERSION
  spec.authors       = [ "nc163" ]
  spec.email         = [ "kou1992@gmail.com" ]

  spec.summary       = "Rails UI Components with ViewComponent"
  spec.description   = "Confining the presentation layer of a Ruby on Rails application."
  spec.homepage      = "https://github.com/nc163"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nc163"
  spec.metadata["changelog_uri"] = "https://github.com/nc163"

  spec.files = Dir[
    "README.md",
    "lib/**/*.rb",
    "lib/**/*.erb"
  ]
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = [ "lib" ]

  # Dependencies
  spec.add_dependency "actionview", "> 7.0"
  spec.add_dependency "activesupport", "> 7.0"
  spec.add_dependency "view_component", "~> 4.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
