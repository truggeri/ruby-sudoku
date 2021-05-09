require "bundler/setup"
require "sudoku"
require "simplecov"

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter])
SimpleCov.start

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def read_puzzle_from_fixture(file)
  puzzle = []
  File.open(file, 'r') do |f|
    f.each_line do |line|
      puzzle.push([])
      line.split.each do |element|
        puzzle.last.push(element.to_i)
      end
    end
  end
  puzzle.flatten
end
