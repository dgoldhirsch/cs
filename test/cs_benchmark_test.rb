require "test_helper"
require File.join(File.dirname(__FILE__), '..', 'lib', 'cs.rb')
require "benchmark"
require "ruby-prof"

class CS_benchmark < Test::Unit::TestCase

  N = 50000
  
  # This isn't a test per se, but rather a very simple performance profiler.
  def test_performance
    y = Benchmark.bmbm do |x|
      x.report("linear_matrix_fibonacci") { CS::linear_matrix_fibonacci(N) }
      x.report("while_loop_fibonacci") { CS::while_loop_fibonacci(N) }
    end
  end
  
  def test_rubyprof
    RubyProf::GraphPrinter.new(RubyProf.profile {CS::linear_matrix_fibonacci(N)}).print(STDOUT, 0)
    RubyProf::GraphPrinter.new(RubyProf.profile {CS::while_loop_fibonacci(N)}).print(STDOUT, 0)
  end
end