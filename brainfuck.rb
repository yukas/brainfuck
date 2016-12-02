class Brainfuck
  attr_reader :input, :output

  CELL_ARRAY_SIZE = 30_000

  def initialize(input, output)
    @input              = input
    @output             = output
    
    @current_cell_index = 0
    @memory             = Array.new(CELL_ARRAY_SIZE, 0)
    @loop_stack         = []
  end
  
  def execute_code(code)
    command_index = 0
    
    while command_index < code.length do
      command = code[command_index]
      
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
        start_a_loop(command_index)
      when "]"
        if another_iteration?
          command_index = beginning_of_the_loop
        else
          finish_a_loop
        end
      end
      
      command_index += 1
    end
  end
  
  private
  attr_reader :memory, :loop_stack, :current_cell_index

  def cell_value_at(cell_index)
    memory[cell_index]
  end
  
  def set_cell_value_at(cell_index, new_value)
    memory[cell_index] = new_value
  end
  
  def current_cell_value
    cell_value_at(current_cell_index)
  end
  
  def set_current_cell_value(value)
    set_cell_value_at(current_cell_index, value)
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
  
  def start_a_loop(command_index)
    loop_stack.push(command_index)
  end
  
  def another_iteration?
    current_cell_value > 0
  end
  
  def beginning_of_the_loop
    loop_stack.last
  end
  
  def finish_a_loop
    loop_stack.pop
  end
end