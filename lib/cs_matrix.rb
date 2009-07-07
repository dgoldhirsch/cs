require 'rubygems'
require 'cs.rb'
require 'matrix' 

# Useful Class Matrix mixins.
#
# <code>
# require 'cs' # get the CS gem
# require 'cs_matrix.rb' # get the CS Matrix mixin
# </code>
#
# And now you can do this:
#
# <code>
#    puts 7.fibonacci() # prints 8
# </code>
class Matrix
  # Useful for dealing with matrices.
  # Return the lower, right-hand element of a given matrix.
  def lower_right
    return CS::lower_right(self)
  end
end