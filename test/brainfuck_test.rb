require 'test_helper'

class BrainfuckTest < Minitest::Test
  def subject
    @subject ||= Brainfuck.new(io)
  end
  
  def io
    @io ||= Minitest::Mock.new
  end
  
  def test_greater_than_sign_increments_the_pointer
    expect_output(0)
    
    subject.execute_code("+>.")
    
    verify_io
  end
  
  def test_less_than_sign_decrements_the_pointer
    expect_output(1)
    
    subject.execute_code("+><.")
    
    verify_io
  end
  
  def test_plus_sign_increments_current_cell_value
    expect_output(1)
    
    subject.execute_code("+.")
    
    verify_io
  end
  
  def test_minus_sign_decrements_current_cell_value
    expect_output(1)
    
    subject.execute_code("++-.")
    
    verify_io
  end
  
  def test_dot_outputs_value_of_the_current_cell
    expect_output(1)
    
    subject.execute_code("+.")
    
    verify_io
  end
  
  def test_comma_reads_value_into_the_current_cell
    expect_input("1")
    expect_output("1")
    
    subject.execute_code(",.")
    
    verify_io
  end
  
  def test_brackets_create_a_cycle
    expect_output(3)
    
    subject.execute_code("+++[>+<-]>.")

    verify_io
  end
  
  def test_jump_forward_past_the_matching_bracket_if_current_value_is_zero
    expect_output(0)
    
    subject.execute_code("[>+++<]>.")
    
    verify_io
  end
  
  def ignore_non_brainfuck_instructions
    expect_output(1)
    
    subject.execute_code("#!+.@")
    
    verify_io
  end
  
  def test_incrementing_255_results_in_a_fatal_error
    assert_raises Brainfuck::FatalError do
      subject.execute_code("++++++++[>++++++++<-]>[<++++>-]<.")
    end
  end
  
  def test_decrementing_0_results_in_a_fatal_error
    assert_raises Brainfuck::FatalError do
      subject.execute_code("-")
    end
  end
  
  def test_going_to_the_left_of_the_starting_cell_is_a_fatal_error
    assert_raises Brainfuck::FatalError do
      subject.execute_code("<")
    end
  end
  
  def test_unbalanced_left_bracket_are_a_fatal_error
    assert_raises Brainfuck::FatalError do
      subject.execute_code("[")
    end
  end

  def test_unbalanced_right_bracket_are_a_fatal_error
    assert_raises Brainfuck::FatalError do
      subject.execute_code("]")
    end
  end
  
  def test_fast_forward_jump_with_nested_brackets
    expect_output(1)
    
    subject.execute_code("[++[]++]+.")
    
    verify_io
  end

  private
  
  def expect_input(value)
    io.expect(:input, value)
  end
  
  def expect_output(value)
    io.expect(:output, nil, [value])
  end
  
  def verify_io
    io.verify
  end
end
