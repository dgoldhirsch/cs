require "test_helper"
require File.join(File.dirname(__FILE__), '..', 'lib', 'cs.rb')
require "benchmark"
require "ruby-prof"

class CS_benchmark < Test::Unit::TestCase

  # This isn't a test per se, but rather a very simple performance profiler.
  def test_performance
    y = Benchmark.bmbm do |x|
      n = 60000
#      x.report("linear matrix") { CS::linear_matrix_fibonacci(n) }
      x.report("simplest") { CS::simplest_fibonacci(n)}
      x.report("list") { CS::list_fibonacci(n) }
    end
  end
  
  def a_test_rubyprof
    n = 5000
    linear_result = RubyProf.profile {CS::linear_matrix_fibonacci(n)}
    simplest_result = RubyProf.profile {CS::simplest_fibonacci(n)}
    list_result = RubyProf.profile {CS::list_fibonacci(n)}

    # Print a graph profile to text
    RubyProf::GraphPrinter.new(linear_result).print(STDOUT, 0)
    RubyProf::GraphPrinter.new(simplest_result).print(STDOUT, 0)
    RubyProf::GraphPrinter.new(list_result).print(STDOUT, 0)
  end
end