require "test_helper"
require "matrix"
require "timeout"

class CsFibonacciTest  < Test::Unit::TestCase

  def test_matrix
    (0..F.size - 1).each { | i | assert_equal F[i], CS::matrix_fibonacci(i)}
  end
  
  def test_addititive
    (0..F.size - 1).each { | i | assert_equal F[i], CS::additive_fibonacci(i)}
  end

  def test_algorithm_parameter
    assert_equal 8, CS::fibonacci(6, CS::MATRIX)
    assert_equal 8, CS::fibonacci(6, CS::ADDITION)
    assert_nil CS::fibonacci(3, :foobar)
  end
  
  # Test for gross performance problems, using a time-out thread.
  # It's possible--at least theoretically--for this test
  # to fail because of system issues rather than the fibonacci
  # generator.  So, if it fails, try it again and/or take its
  # failure with a grain of salt.
  def test_raw_performance
    assert_nothing_raised do
      # 20 seconds would seem to be far more than is necessary for this...
      Timeout::timeout(20) {CS::matrix_fibonacci(10000)}
    end
  end

  # Test our understanding of the Ruby matrix module
  def test_matrix
    m = Matrix[[0, 1],[1, 1]]
    m2 = m*m
    m3 = m2*m
    m4 = m3*m
    m2squared = m2**2
    assert_equal 1, CS::lower_right(m)
    assert_equal 2, CS::lower_right(m2)
    assert_equal 3, CS::lower_right(m3)
    assert_equal 5, CS::lower_right(m4)
    assert_equal m4, m2squared
    e = Matrix[]
    assert_nil CS::lower_right(e)
  end

  #The following function will take a massive amount of CPU time and an impossible amount of memory,
  #because it uses the 2**n recursive algorithm to compute Fibonacci number n.  If you want
  #proof that the recursive algorithm is intractible, rename this function 'test_something', and
  #watch your test runner run out of memory (slowly......)
  def zzz_test_recursive  # rename test_recursive, if you want to run it
    assert_equal 0, recursive_fibonacci(1)
    assert_equal 1, recursive_fibonacci(2)
    assert_equal 1, recursive_fibonacci(3)
    assert_equal 2, recursive_fibonacci(4)
    assert_equal 3, recursive_fibonacci(5)
    assert_equal 5, recursive_fibonacci(6)
    assert_equal 8, recursive_fibonacci(7)
    x = recursive_fibonacci(1000); # gonna take a loooooonnnnnngggggg time.....
    assert x > 0
  end

  private

  # Fhe first few Fibonacci numbers, starting with F(0), for assertion comparisons
  F = [0, 1, 1, 2, 3, 5, 8]

    # Seemingly innocent, recursive algorithm that computes the nth Fibonacci number.
  # Requires 2**n recursive calls, requiring an obscene amount of memory and CPU time.
  # Try it for n = 1000, and then twiddle your thumbs while waiting for the "out of memory"
  # exception... 
  def recursive_fibonacci(n)
    if (n == 1)
      return 0
    elsif (n == 2 || n == 3)
      return 1
    end
    return recursive_fibonacci(n - 2) + recursive_fibonacci(n - 1)
  end
end