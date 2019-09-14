
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sudoku/version"

Gem::Specification.new do |spec|
  spec.name          = "sudoku"
  spec.version       = Sudoku::VERSION
  spec.authors       = ["Thomas Ruggeri"]
  spec.email         = ["truggeri@gmail.com"]

  spec.summary       = %q{Sudoku puzzle solver written in Ruby.}
  spec.description   = %q{This project is meant to be a small experiment with Ruby. The app is a sudoku solver.}
  spec.homepage      = "https://github.com/truggeri/ruby-sudoku"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
