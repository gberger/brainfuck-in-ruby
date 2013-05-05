class BrainRubyck

  # These are accessible to be modified after the object has been instantiated
  attr_accessor :code, :logging, :dump_all

  # These are only readable, for debugging purposes and whatnot
  attr_reader :cursor, :memory, :out

  def initialize(opts = {})
    # The Brainfuck code
    @code = opts[:code] || ""

    # The cursor position
    @cursor = 0

    # The memory set
    initial_memory = opts[:initial_memory] || 300
    @memory = Array.new(initial_memory, 0)

    # If true, logs every operation and dumps the memory at the end
    @logging = opts[:logging] || opts[:log] || opts[:debug] || false

    # If true, dumps the memory after every operation
    @dump_all = opts[:dump_all] || false

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

    @loops = []
  end

  def parse!
    # The char we're at in the @code string
    @i = 0

    # The output of the program
    @out = ""

    # Using while so we can manipulate the index
    while @i < @code.length
      cmd = @commands[@code[@i]]

      if cmd.nil?
        next_i
      else
        log(:before, cmd) if @logging
        self.send(cmd)
        log(:after, cmd) if @logging
        self.dump if @dump_all
      end

    end

    # Log the final state of memory at the end of the program
    if @logging
      puts "END OF PROGRAM"
      self.dump 
    end

    # Return the output
    @out
  end

  # Debugging methods
  def dump
    puts "Memory size:#{@memory.length}"
    puts "Data as bytes: #{@memory.join(' ')}"
    puts "Data as chars: " + @memory.map {|b| b.chr}.join(' ')
    @memory
  end

private

  def log (whn, cmd)
    if whn == :before
      print "Before command "
    else
      print "After command "
    end
    print "'#{cmd}' (#{@code[@i]}): i: #{@i}, cursor: #{@cursor}, byte: #{@memory[@cursor]}, char: #{@memory[@cursor].chr}\n"
  end

  # Brainfuck commands
  def plus
    @memory[@cursor] += 1
    next_i
  end

  def minus
    @memory[@cursor] -= 1
    next_i
  end

  def forward
    @cursor += 1
    next_i
  end

  def backward
    @cursor -= 1
    next_i
  end

  def begin_loop
    @loops.push(@i)
    next_i
  end

  def end_loop
    if @memory[@cursor] == 0
      @loops.pop
      next_i
    else
      @i = @loops.last
    end
  end

  def output
    ch = @memory[@cursor].chr 
    print ch
    @out << ch
    next_i
  end

  def input
    @memory[@cursor] = gets[0].ord
    next_i
  end

  # Helpers
  def next_i
    @i += 1
  end
end