class BrainRubyck

  def initialize(code, memory_limit=300, logging=false)
    # The Brainfuck code
    @code = code

    # The cursor position
    @position = 0

    # The memory set
    @memory = Array.new(memory_limit, 0)

    # If true, logs every operation
    @logging = logging

    # The Brainfuck commands
    @commands = {
      '+' => :plus,
      '-' => :minus,
      '>' => :forward,
      '<' => :backward,
      '[' => :begin_loop,
      ']' => :end_loop,
      '.' => :output,
      ',' => :input
    }
  end

  def parse
    @code.each_char do |c|
      puts [c, @commands[c], @commands[c].nil?].join(' ')
    end
  end

end

r = BrainRubyck.new('+-><[] a#')
r.parse