require "test_helper"
require File.join(File.dirname(__FILE__), '..', 'lib', 'cs.rb')
require "benchmark"
require "ruby-prof"

class CS_benchmark < Test::Unit::TestCase

  N = 50000  # large enough to show a difference
  
  # This isn't a test per se, but rather a very simple performance profiler.
  def test_performance
    y = Benchmark.bmbm do |x|
      x.report("matrix_fibonacci") { CS::matrix_fibonacci(N) }
      x.report("additive_fibonacci") { CS::additive_fibonacci(N) }
    end
  end
  
  def test_rubyprof
    RubyProf::GraphPrinter.new(RubyProf.profile {CS::matrix_fibonacci(N)}).print(STDOUT, 0)
    RubyProf::GraphPrinter.new(RubyProf.profile {CS::additive_fibonacci(N)}).print(STDOUT, 0)
  end
end