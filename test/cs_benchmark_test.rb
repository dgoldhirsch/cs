require "test_helper"
require File.join(File.dirname(__FILE__), '..', 'lib', 'cs.rb')
require "benchmark"
require "ruby-prof"

class CS_benchmark < Test::Unit::TestCase

  N = 50000
  
  # This isn't a test per se, but rather a very simple performance profiler.
  def test_performance
    y = Benchmark.bmbm do |x|
      x.report("linear matrix") { CS::linear_matrix_fibonacci(N) }
    end
  end
  
  def test_rubyprof
    linear_result = RubyProf.profile {CS::linear_matrix_fibonacci(N)}
    RubyProf::GraphPrinter.new(linear_result).print(STDOUT, 0)
  end
end