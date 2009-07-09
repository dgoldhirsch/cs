require 'rubygems'
require 'matrix'

# Title:: Computer Science Library for Ruby
# Author:: David C. Goldhirsch
# Copyright (c) 2009, David C. Goldhirsch
module CS

  ########################################## Fibonacci Algorithms

  MATRIX = :matrix
  ADDITION = :addition
  Fibonacci_algorithms = [MATRIX, ADDITION]

  # Generalized Fibonacci generator.
  # Return the integer value of F(n) for any integer n, where
  # F(0) = 0
  # F(1) = 1
  # F(k > 1) = F(k - 1) + F(k - 2)
  # Starting with F(0), the first few Fibonacci values are 0, 1, 1, 2, 3, 5, 8, ...
  #
  # Usage:   CS::fibonacci(anInteger, aSymbol = CS::MATRIX)
  # in which anInteger is any integer (but anything less than 0 will be
  # interpreted as 0), and aSymbol optionally specifies the algorithm to be
  # used.  See this module's Fibonacc_algorithms constant for the possible
  # algorithm names.  By default, the fastest known algorithm will be used.
  def self.fibonacci(n, algorithm = MATRIX)
    # The following seems to be the fastest algorithm, perhaps because
    # Ruby's Matrix.** operation is smart enough to use squares of squares
    # to minimize the number of multiplications.
    return matrix_fibonacci(n) if algorithm == MATRIX
    return additive_fibonacci(n) if algorithm == ADDITION
  end

  # Matrix utility to return
  # the lower, right-hand element of a given matrix.
  def self.lower_right matrix
    return nil if matrix.row_size == 0
    return matrix[matrix.row_size - 1, matrix.column_size - 1]
  end
  
  # Matrix exponentiation algorithm to compute Fibonacci numbers.
  # Let M be Matrix [[0, 1], [1, 1]].  Then, the lower right element of M**k is
  # F(k + 1).  In other words, the lower right element of M is F(2) which is 1, and the
  # lower right element of M**2 is F(3) which is 2, and the lower right element
  # of M**3 is F(4) which is 3, etc.
  #
  # This is a good way to compute F(n) because the Ruby implementation of Matrix.**
  # uses an O(log n) optimized algorithm (*).  Computing M**(n-1) is actually
  # faster (**) than using a simple while/for loop to compute F(0) + F(1) + ... + F(n-1).
  #
  # We found this algorithm in <I>Introduction To Algorithms
  # (Second Edition)</I>, by Cormen, Leiserson, Rivest, and Stein, MIT Press
  # (http://mitpress.mit.edu), in exercise 3-31 on pages 902, 903.
  #
  # (*) Ruby's Matrix.**(k) works by computing partial = ((m**2)**2)... as far as possible,
  # and then multiplying partial by M**(the remaining number of times).  E.g., to compute
  # M**19, compute partial = ((M**2)**2) = M**16, and then compute partial*(M**3) = M**19.
  # That's only 3 matrix multiplications of M to compute M*19.
  #
  # (**) "Faster" means on the workstations we tried, the matrix algorithm takes less total time
  # (see Ruby's Benchmark::bmbm) than a simple, additive loop.  But the space complexity
  # may well be larger for the matrix algorithm, which in turn may affect the likelihood
  # of garbage collection in large cases.  Therefore, as with almost everything else,
  # a different algorithm may be better suited to any particular environment or situation.
  # This is why we provide the optional, alternative algorithms.
  # 
  def self.matrix_fibonacci(n)
    return 0 if n <= 0 # F(0)
    return 1 if n == 1 # F(1)
    # To get F(n >= 2), compute M**(n - 1) and extract the lower right element.
    return CS::lower_right(M**(n - 1))
  end

  # This is a simple, additive loop to compute F(n) by computing
  # F(0) + F(1) + ... + F(n-1).  Our spotty benchmark/profiling suggests that
  # this is always worse in CPU time and general response time than
  # the linear_matrix_fibonacci algorithm.  (And, surprisingly, this seems to be true even
  # for very low values of n.)  We provide it for purposes of information, and as
  # a point of comparison for performance.
  def self.additive_fibonacci(n)
    return 0 if n <= 0
    b = 0 # F(0)
    result = 1 # F(1)
    (n - 1).times do
      a = b
      b = result
      result += a # i.e., result = a + b
    end
    return result
  end

  private

  # To understand why this matrix is useful for Fibonacci numbers, remember
  # that the definition of Matrix.** for any Matrix[[a, b], [c, d]] is
  # is [[a*a + b*c, a*b + b*d], [c*a + d*b, c*b + d*d]].  In other words, the
  # lower right element is computing F(k - 2) + F(k - 1) every time M is multiplied
  # by itself (it is perhaps easier to understand this by computing M**2, 3, etc, and
  # watching the result march up the sequence of Fibonacci numbers).
  M = Matrix[[0, 1], [1,1]]

end
