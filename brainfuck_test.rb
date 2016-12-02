require 'minitest/autorun'

require_relative 'brainfuck'

class BrainfuckTest < Minitest::Test
  def subject
    @subject ||= Brainfuck.new(input, output)
  end
  
  def output
    Minitest::Mock.new
  end
  
  def input
    Minitest::Mock.new
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
    subject.execute_code(">")
    
    assert_equal 1, subject.current_cell_index
  end
  
  def test_less_than_sign_decrements_the_pointer
    subject.execute_code(">>><")
    
    assert_equal 2, subject.current_cell_index
  end
  
  def test_plus_sign_increments_current_cell_value
    subject.execute_code("+")
    
    assert_equal 1, subject.current_cell_value
  end
  
  def test_minus_sign_decrements_current_cell_value
    subject.set_current_cell_value(5)
    
    subject.execute_code("-")
    
    assert_equal 4, subject.current_cell_value
  end
  
  def test_dot_outputs_value_of_the_current_cell
    subject.set_current_cell_value("a")
    subject.output.expect(:puts, nil, ["a"])
    
    subject.execute_code(".")
    
    subject.output.verify
  end
  
  def test_comma_reads_value_into_the_current_cell
    subject.input.expect(:gets, "b")
    
    subject.execute_code(",")
    
    subject.input.verify
    assert_equal "b", subject.current_cell_value
  end
  
  def test_brackets_create_a_cycle
    subject.execute_code("+++[>+<-]>")

    assert_equal 3, subject.current_cell_value
  end
end
