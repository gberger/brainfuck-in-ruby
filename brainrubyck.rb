class BrainRubyck
  def self.new(code, memory_limit=300, logging=false)
    # The Brainfuck code
    @code = code

    # The cursor position
    @position = 0

    # The memory set
    @memory = Array.new(memory_limit, 0)

    # If true, logs every operation
    @logging = logging
  end
end

r = BrainRubyck.new('+.')