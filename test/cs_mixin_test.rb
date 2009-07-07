require "test_helper"
require "../lib/fibonacci.rb"

# Test mixin wrappers for the CS library.  This is just
# for the mixin wrappers--the hard core tests for the
# CS library itself should be written against the CS module
# directly.
class CsMixinTest  < Test::Unit::TestCase

  def test_fibonacci_mixin
    x = 7.fibonacci # ensure works with Fixnum
    # Use reflection to ensure that it works
    # with Bignums ('cause, it'd take a loooonnnnnggg
    # time to compute the fibonacci number of a Bignum).
    y = 0xfffffffffe # Bignum on any 32-bit system
    assert y.method(:fibonacci)
  end

end