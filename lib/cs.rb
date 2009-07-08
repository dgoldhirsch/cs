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
    # The following seems to be the fastest algorithm, perhaps because
    # Ruby's Matrix.** operation is smart enough to use squares of squares
    # to minimize the number of multiplications.
    return linear_matrix_fibonacci(n)
  end

  # Matrix utility to return
  # the lower, right-hand element of a given matrix.
  def self.lower_right matrix
    return nil if matrix.row_size == 0
    return matrix[matrix.row_size - 1, matrix.column_size - 1]
  end
  
  private

  # Linear matrix multiplication algorithm to compute Fibonacci numbers generator.
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
    return CS::lower_right(M**(n - 1)) # F(p.power)
  end

  M = Matrix[[0, 1], [1,1]]

end
