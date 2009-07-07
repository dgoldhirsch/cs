require 'rubygems'

# Title:: Computer Science Library for Ruby
# Author:: David C. Goldhirsch
# Copyright (c) 2009, David C. Goldhirsch
module CS
  # Fibonacci number generator.
  # Return integer value of F(n) for any integer n >= 1,
  # where F(n) is defined as F(n - 1) + F(n - 2) for n > 2, F(1) = 1
  # and F(0) = 0.
  #
  # E.g., the sequence (F(0), ..., F(7)) is (0, 1, 1, 2, 3, 5, 8, 13).
  #
  # Values of n less than 0 are equivalent to n = 0.
  def self.fibonacci n
    return 0 if n <= 0
    return FibonacciOneOrHigher.advanced_by(n - 1).result
  end

  def self.matrix_fibonacci n
    return MatrixFibonacciGenerator.for(n).result
  end

  # Useful for dealing with matrices.
  # Return the lower, right-hand element of a given matrix.
  def self.lower_right matrix
    return nil if matrix.row_size == 0
    return matrix[matrix.row_size - 1, matrix.column_size - 1]
  end
  
end

private

# O(log n) Fibonacci generating class, each of whose instances represents F(1 + k)
# for some given k. To obtain the integer value of F(w), use the 'result' method, e.g.:
# - f = FibonacciOneOrHigher.new
# - f.result # the integer 1 = F(1)
# - f.advance
# - f.result # the integer 1 = F(2)
# - f.advance
# - f.result # the integer 2 = F(3)
# - etc.
#
# This algorithm uses a combination of matrix multiplication and the slower, O(n)
# algorithm.  For small n (say, under 500,000) it isn't worth using this--just
# use the O(n) algorithm and save yourself the overhead of the matrix stuff.
module MatrixFibonacciGenerator
  def self.for n
    return 0 if n <= 0 # F(0)
    return 1 if n == 1 # F(1)
    p = PowerOfTwo.new(n - 2) # n - 2 is number of times to multiply matrix
    m = Matrix[[0, 1], [1,1]]**p.power
    f = FibonacciOneOrHigher.from(CS::lower_right(m))
    p.remaining.times {f.advance}
    return f
  end
end

class PowerOfTwo
  attr_accessor :power
  attr_accessor :value
  attr_accessor :n
  def initialize n
    self.n = n
    compute_highest_power_of_two_less_than_input
  end

  def remaining
    return self.n - self.value
  end
  
  private

  def compute_highest_power_of_two_less_than_input
    p = 0
    v = 1
    while v * 2 <= n do
      p += 1
      v *= 2
    end
    self.power = p
    self.value = v
  end
end
# O(n) Fibonacci generating class, each of whose instances represents F(1 + k)
# for some given k. To obtain the integer value of F(w), use the 'result' method, e.g.:
# - f = FibonacciOneOrHigher.new
# - f.result # the integer 1 = F(1)
# - f.advance
# - f.result # the integer 1 = F(2)
# - f.advance
# - f.result # the integer 2 = F(3)
# - etc.
#
# This algorithm uses naive loop to compute F(2) from F(1) and F(0), and then
# F(3), etc.

class FibonacciOneOrHigher
  attr_accessor :result
  attr_accessor :previous
  attr_accessor :second_previous  # non-nil only for F(3) and higher

  # This is the proper way to create an instance
  # representing F(1 + k).  Please use this instead of 'new'.
  # Return an instance representing F(1 + k) for given k.
  # E.g., if k is 0, the result is F(1);  if k is 1, the
  # result is F(2);  if k is 4 the result is F(5)
  def self.advanced_by k
    return FibonacciOneOrHigher.new.advance_by(k)
  end

  # Change internal state such that if the receiver currently
  # represents F(k) it will be advanced to represent F(k + 1).
  def advance
    self.second_previous = self.previous
    self.previous = self.result
    self.result += self.second_previous # i.e., second_previous + previous
    return self
  end

  def advance_by k
    k.times {self.advance}
    return self
  end

  def to_s
    return second_previous.to_s + "," + previous.to_s + "," + "=>" + result.to_s
  end

  private

  # Instances represent F(1), unless/until they are advanced
  def initialize
    self.previous = 0 # F(0)
    self.result = 1 # F(1)
  end
end
