Gem::Specification.new do |spec|
  spec.name          = "hyperlist"
  spec.version       = "1.1.5"
  spec.authors       = ["Geir Isene"]
  spec.email         = ["g@isene.com"]

  spec.summary       = "A powerful Terminal User Interface for HyperList management"
  spec.description   = "HyperList is a Ruby TUI application for creating, editing, and managing hierarchical lists using the HyperList methodology. It features rich syntax highlighting, advanced folding, powerful navigation, full editing capabilities, checkbox support, encryption for sensitive data, enhanced presentation mode, and multiple export formats."
  spec.homepage      = "https://github.com/isene/HyperList"
  spec.license       = "Unlicense"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/isene/HyperList"
  spec.metadata["documentation_uri"] = "https://isene.org/hyperlist/"
  spec.metadata["changelog_uri"] = "https://github.com/isene/HyperList/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[test/ spec/ features/ .git .github .gitignore])
    end
  end

  spec.bindir        = "."
  spec.executables   = ["hyperlist"]
  spec.require_paths = ["."]

  # Runtime dependencies
  spec.add_runtime_dependency "rcurses", "~> 5.1", ">= 5.1.5"
  
  # Development dependencies
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 13.0"
end