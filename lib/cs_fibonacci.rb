require 'rubygems'
require 'cs.rb'

# Integer mixin providing Integer.fibonacci() instance method
# that delegates to CS::fibonacci.  Type the following:
#
# <code>
# require 'cs' # get the gem
# require 'cs_fibonacci.rb' # get the Integer mixin
# </code>
#
# And now you can do this:
#
# <code>
#    puts 7.fibonacci() # prints 8
# </code>
class Integer
  def fibonacci
    return CS::fibonacci(self)
  end
end