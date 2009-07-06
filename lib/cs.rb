require 'rubygems'

# Title:: Computer Science Library for Ruby
# Author:: David C. Goldhirsch
# Copyright (c) 2009, David C. Goldhirsch
class CS
  # Fibonacci number generator.
  # Return integer value of F(n) for any integer n >= 1,
  # where F(n) is defined as F(n - 1) + F(n - 2) for n > 2, F(2) = 1
  # and F(1) = 0.
  #
  # E.g., the sequence (F(1), ..., F(7)) is (0, 1, 1, 2, 3, 5, 8).
  #
  # Values of n less than 1 are equivalent to n = 1.
  def self.fibonacci n
    return 0 if n <= 1
    return (FibonacciSecondOrHigher.advanced_by n - 2).result
  end

  private

  # The class 'new' method is privatized, because users should not be
  # instantiating this class.
  def self.new
    super.new
  end
end

private

# Fibonacci generating class, each of whose instances represents F(2 + k)
# for some given k. To obtain the integer value of F(w), use the 'result' method, e.g.:
# - f = FibonacciSecondOrHigher.new
# - f.result # the integer 1 = F(2)
# - f.advance
# - f.result # the integer 2 = F(3)
# - etc.
class FibonacciSecondOrHigher
  attr_accessor :result
  attr_accessor :previous
  attr_accessor :second_previous  # non-nil only for F(3) and higher

  # This is the proper way to create an instance
  # representing F(2 + k).  Please use this instead of 'new'.
  # Return an instance representing F(2 + k) for given k.
  # E.g., if k is 0, the result is F(2);  if k is 1, the
  # result is F(3);  if k is 4 the result is F(6)
  def self.advanced_by k
    return (1..k).inject(FibonacciSecondOrHigher.new) do |f, i|
      f.advance
    end
  end

  # Change internal state such that if the receiver currently
  # represents F(k) it will be advanced to represent F(k + 1).
  def advance
    self.second_previous = self.previous
    self.previous = self.result
    self.result += self.second_previous # i.e., second_previous + previous
    return self
  end

  def to_s
    return second_previous.to_s + "," + previous.to_s + "," + "=>" + result.to_s
  end

  private

  # Instances represent F(2), unless/until they are advanced
  def initialize
    self.previous = 0 # F(<= 1)
    self.result = 1 # F(2)
  end
end
