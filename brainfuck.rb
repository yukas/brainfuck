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
  
  def test_pointer_is_point_to_beginning_of_memory
    assert_equal 0, subject.current_cell_index
  end
  
  def test_greater_than_sign_increments_the_pointer
    subject.code = ">"
    subject.execute_code
    
    assert_equal subject.current_cell_index, 1
  end
end

class Brainfuck
  CELL_ARRAY_SIZE = 30_000
  
  attr_reader :current_cell_index
  attr_accessor :code
  
  def initialize
    @current_cell_index = 0
  end
  
  def execute_code
    @current_cell_index += 1
  end
  
  def cell_value_at(cell_index)
    0
  end
end