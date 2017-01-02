class Brainfuck
  attr_reader :io, :encoding

  class FatalError < RuntimeError
  end

  def initialize(io)
    @io = io
  end
  
  def execute_code(code)
    Compiler.new(code, io).run
  end
  
  class IO
    attr_reader :encoding
    
    INPUT  = STDIN
    OUTPUT = STDOUT
    
    def initialize(encoding)
      @encoding = encoding
    end
    
    def input
      encoding.decode(INPUT.gets.chomp)
    end
    
    def output(value)
      OUTPUT.print(encoding.encode(value))
    end
  end
  
  class Compiler
    CELL_ARRAY_SIZE = 30_000
    
    attr_reader :code, :io
    
    def initialize(code, io)
      @code = code
      @io   = io
      
      @memory             = Array.new(CELL_ARRAY_SIZE, 0)
      @command_index      = 0
      @current_cell_index = 0
      @loop_stack         = []
    end
    
    def run
      raise_fatal_error("Unbalanced brackets") if unbalanced_brackets?
    
      while command_index < code.length do
        case command
        when ">"
          increment_current_cell_index
        when "<"
          decrement_current_cell_index
        when "+"
          increment_current_cell_value
        when "-"
          decrement_current_cell_value
        when ","
          input_current_cell_value
        when "."
          output_current_cell_value
        when "["
          if can_start_a_loop?
            start_a_loop
          else
            jump_forward_past_the_matching_bracket
          end
        when "]"
          if can_finish_a_loop?
            finish_a_loop
          else
            move_to_the_beginning_of_the_loop
          end
        end
      
        move_command_index
      end
    end
  
    private
    
    attr_reader :memory, :command_index, :current_cell_index, :loop_stack
    
    def unbalanced_brackets?
      stack = []
    
      code.chars.each do |char|
        if char == "["
          stack << "]"
        elsif char == "]"
          return true if stack.pop != "]"
        end
      end

      !stack.empty?
    end
    
    def command
      code[command_index]
    end
  
    def increment_current_cell_index
      @current_cell_index += 1
    end
  
    def decrement_current_cell_index
      cell_index = @current_cell_index - 1
    
      raise_fatal_error("Attempting to go to the left of the starting cell") if cell_index < 0
    
      @current_cell_index = cell_index
    end
  
    def raise_fatal_error(message)
      raise FatalError.new(message)
    end
  
    def increment_current_cell_value
      cell_value = current_cell_value + 1
    
      raise_fatal_error("Incrementing cell value of 255") if cell_value > 255
    
      set_current_cell_value(cell_value)
    end
  
    def decrement_current_cell_value
      cell_value = current_cell_value - 1
    
      raise_fatal_error("Decrementing cell value of 0") if cell_value < 0
    
      set_current_cell_value(cell_value)
    end
  
    def input_current_cell_value
      set_current_cell_value(io.input)
    end
  
    def output_current_cell_value
      io.output(current_cell_value)
    end
  
    def can_start_a_loop?
      current_cell_value > 0
    end
  
    def jump_forward_past_the_matching_bracket
      stack = ["]"]
    
      while !stack.empty?
        move_command_index
      
        if command == "["
          stack << "]"
        elsif command == "]"
          stack.pop
        end
      end
    end
  
    def start_a_loop
      loop_stack.push(command_index)
    end
  
    def can_finish_a_loop?
      current_cell_value == 0
    end
  
    def move_to_the_beginning_of_the_loop
      @command_index = loop_stack.last
    end
  
    def finish_a_loop
      loop_stack.pop
    end
  
    def move_command_index
      @command_index += 1
    end
  
    def set_current_cell_value(value)
      memory[current_cell_index] = value
    end
  
    def current_cell_value
      memory[current_cell_index]
    end
  end
end