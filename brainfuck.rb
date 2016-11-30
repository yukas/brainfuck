class Brainfuck
  attr_reader :input, :output
  attr_reader :current_cell_index
  
  CELL_ARRAY_SIZE = 30_000

  def initialize(input, output)
    @input              = input
    @output             = output
    @current_cell_index = 0
    @memory             = Array.new(CELL_ARRAY_SIZE, 0)
  end
  
  def execute_code(code)
    code.each_char do |command|
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
      end
    end
  end
  
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
  
  private
  attr_reader :memory
  
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
end