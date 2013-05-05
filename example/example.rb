require_relative '../brainrubyck.rb'

br = BrainRubyck.new
br.code = '++Comment++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.'
# br.logging = true

br.parse!