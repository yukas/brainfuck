require "minitest/autorun"

class BrainfuckTest < Minitest::Test
  def subject
    @subject ||= Brainfuck.new
  end
  
  def test_size_of_memory_is_less_than_30000_cells
    assert_equal 30_000, Brainfuck::CELL_ARRAY_SIZE
  end
  
  def test_memory_is_initialized_to_zero
    assert_equal 0, subject.cell_value_at(29_999) 
  end
  
  def test_pointer_points_to_beginning_of_memory
    assert_equal 0, subject.current_cell_index
  end
  
  def test_greater_than_sign_increments_the_pointer
    subject.code = ">"
    subject.execute_code
    
    assert_equal 1, subject.current_cell_index
  end
  
  def test_less_than_sign_decrements_the_pointer
    subject.code = ">>><"
    subject.execute_code
    
    assert_equal 2, subject.current_cell_index
  end
  
  def test_plus_sign_increments_current_cell_value
    subject.code = "+"
    subject.execute_code
    
    assert_equal 1, subject.current_cell_value
  end
  
  def test_minus_sign_decrements_current_cell_value
    subject.set_current_cell_value(5)
    
    subject.code = "-"
    subject.execute_code
    
    assert_equal 4, subject.current_cell_value
  end
end

class Brainfuck
  CELL_ARRAY_SIZE = 30_000
  
  attr_reader :current_cell_index
  attr_accessor :code
  
  def initialize
    @current_cell_index = 0
    @memory = Array.new(CELL_ARRAY_SIZE, 0)
  end
  
  def execute_code
    code.each_char do |command|
      case command
      when ">"
        @current_cell_index += 1
      when "<"
        @current_cell_index -= 1
      when "+"
        set_cell_value_at(current_cell_index, cell_value_at(current_cell_index) + 1)
      when "-"
        set_current_cell_value(current_cell_value - 1)
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
end