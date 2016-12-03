class Brainfuck
  attr_reader :input, :output

  CELL_ARRAY_SIZE = 30_000

  def initialize(input, output)
    @input  = input
    @output = output
    
    @command_index      = 0
    @current_cell_index = 0
    @memory             = Array.new(CELL_ARRAY_SIZE, 0)
    @loop_stack         = []
  end
  
  def execute_code(code)
    @code = code
    
    while enough_commands_to_execute? do
      execute_command
      move_command_index
    end
  end
  
  private
  attr_reader :code, :command_index, :memory, :loop_stack, :current_cell_index
  
  def enough_commands_to_execute?
    command_index < code.length
  end
  
  def execute_command
    case command
    when ">"
      increment_current_cell_index
    when "<"
      decrement_current_cell_index
    when "+"
      increment_current_cell_value
    when "-"
      decrement_current_cell_value
    when "."
      output_current_cell_value
    when ","
      input_current_cell_value
    when "["
      start_a_loop
    when "]"
      if another_iteration?
        move_to_the_beginning_of_the_loop
      else
        finish_a_loop
      end
    end
  end
  
  def command
    code[command_index]
  end
  
  def increment_current_cell_index
    @current_cell_index += 1
  end
  
  def decrement_current_cell_index
    @current_cell_index -= 1
  end
  
  def increment_current_cell_value
    set_current_cell_value(current_cell_value + 1)
  end
  
  def decrement_current_cell_value
    set_current_cell_value(current_cell_value - 1)
  end
  
  def output_current_cell_value
    output.puts(current_cell_value)
  end
  
  def input_current_cell_value
    set_current_cell_value(input.gets)
  end
  
  def start_a_loop
    loop_stack.push(command_index)
  end
  
  def another_iteration?
    current_cell_value > 0
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