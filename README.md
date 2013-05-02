Brainrubyck
===========

A Brainfuck interpreter written in Ruby.

Usage
-----
```ruby
# Require it
require 'brainruyck'

# Create a interpreter instance
br = BrainRubyck.new

# Give it some code
br.code = '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.'

# Parse it!
br.parse!
# => "Hello World\n"

# The output can also be found in an instance variable
br.out

# You can access the cursor location integer and the memory array
br.cursor
br.memory

# A pretty print of the memory can be obtained via the #dump method
br.dump

# You can pass the ::new method an options hash
opts = {
  code: '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.',
  logging: true,
  dump_all: true,
  initial_memory: 50
}
br2 = BrainRubyck.new(opts)

# The first three of these can also be set later
br3 = BrainRubyck.new
br3.code = '+++++[>++++++++++<-]>.'
br3.logging = true
br3.dump_all = true
```