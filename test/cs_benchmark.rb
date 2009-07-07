require "test_helper"
require "../lib/cs"
require "benchmark"

class CS_benchmark < Test::Unit::TestCase

  # This isn't a test per se, but rather a very simple performance profiler.
  def test_performance
    y = Benchmark.bmbm do |x|
      n = 60000
      x.report("linear") { CS::linear_addition_fibonacci(n) }
      x.report("slow matrix") { CS::linear_matrix_fibonacci(n)}
      x.report("binary matrix") { CS::hybrid_matrix_fibonacci(n) }
      x.report("hybrid matrix") { CS::hybrid_matrix_fibonacci(n) }
    end
  end
end