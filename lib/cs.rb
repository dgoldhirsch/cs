require 'rubygems'
require 'matrix'

# Title:: Computer Science Library for Ruby
# Author:: David C. Goldhirsch
# Copyright (c) 2009, David C. Goldhirsch
module CS

  # Generalized Fibonacci generator.
  # Return the integer value of F(n) for any integer n, where
  # F(0) = 0
  # F(1) = 1
  # F(k > 1) = F(k - 1) + F(k - 2)
  # Starting with F(0), the first few Fibonacci values are 0, 1, 1, 2, 3, 5, 8, ...
  # 
  def self.fibonacci(n)
    # Simply delegate to the fastest of our algorithms, because
    # this one seems to beat the others no matter how small n is.
    return hybrid_matrix_fibonacci(n)
  end

  # Linear (O(n)) addition algorithm to compute Fibonacci numbers.
  # It computes F(0) + F(1) + ... + F(n - 1) in order to return F(n).  This
  # seems to perform fine for n <= 10,000, but in no case is it faster
  # than our matrix algorithms.  So, there's no good reason to use this.
  def self.linear_addition_fibonacci(n)
    return 0 if n <= 0
    return FibonacciOneOrHigher.new.advance_by(n - 1).result
  end

  # Linear matrix multiplication algorithm to compute Fibonacci numbers generator.
  # As described in the book, <I>Introduction to Algorithms (Second Edition)</I>, by
  # Cormen, Leiserson, Rivest, Sten (see Problem 31-3 on pages 902, 903), F(n)
  # is the lower right element of the matrix M raised to the n - 1'st power, where
  # M = Matrix[[0, 1], [1, 1]].
  #
  # The Ruby implementation of Matrix.** seems to be very good, indeed, because
  # this implementation is VERY much faster than that of linear addition (even
  # though more arithmetic would seem to be needed for the matrix multiplications).
  # It would be interesting to know why this is the case.
  def self.linear_matrix_fibonacci(n)
    return 0 if n <= 0 # F(0)
    return 1 if n == 1 # F(1), equivalent to matrix M(0) = [[0, 1], [1, 1]].
    # We want M(n - 1) = M(0)**(n-1) which is equivalent to F(n).
    previous = Matrix[[0, 1], [1,1]]**(n - 1)
    result = CS::lower_right(previous**2) # F(p.power)
    return result
  end

  # This algorithm divides the problem into two portions:  first, raise the matrix M to the highest
  # power of 2 such that the result is less then F(n).  Call the result F(k <= n), and
  # then use the simple, lineary, addition to advance that to F(n).
  def self.hybrid_matrix_fibonacci(n)
    return 0 if n <= 0 # F(0)
    return 1 if n == 1 # F(1), equivalent to matrix M(0) = [[0, 1], [1, 1]].
    # We want M(n - 1) = M(0)**(n-1) which is equivalent to F(n).
    # Let the spiffy Matrix.** algorithm do this.
    p = PowerOfTwo.new(n - 1);
    previous = Matrix[[0, 1], [1,1]]**(p.power - 1)
    result = previous**2 # F(p.power)
    # Bootstrap F(p.power, p.value), to be advanced linearly to n - 2
    f = FibonacciOneOrHigher.for_previous_and_result(CS::lower_right(previous), CS::lower_right(result))
    f.advance_by(p.remaining)
    return f.result
  end

  # This algorithm divides the problem into two portions, just like hybrid_matrix_fibonacci.
  # Instead of using the linear addition to advance from F(k < n) to F(n), it uses one additional
  # call to Matrix.**.
  def self.binary_matrix_fibonacci(n)
    return 0 if n <= 0 # F(0)
    return 1 if n == 1 # F(1), equivalent to matrix M(0) = [[0, 1], [1, 1]].
    # We want M(n - 1) = M(0)**(n-1) which is equivalent to F(n).
    # Let the spiffy Matrix.** algorithm do this.
    p = PowerOfTwo.new(n - 1);
    previous = Matrix[[0, 1], [1,1]]**(p.power) # presumed to be specially optimized
    result = CS::lower_right(previous**p.remaining)
  end

  # Matrix utility to return
  # the lower, right-hand element of a given matrix.
  def self.lower_right matrix
    return nil if matrix.row_size == 0
    return matrix[matrix.row_size - 1, matrix.column_size - 1]
  end

  def self.squared_by matrix, n
    result = matrix;
    n.times {result *= result}
    return result;
  end
end

private

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

  def self.for_previous_and_result(previous, current)
    result = self.new
    result.previous = previous
    result.result = current
    return result
  end

  # Create a Fibonacci generator whose current result is a given (Fibonacci)
  # number.

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
