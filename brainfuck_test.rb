require 'minitest/autorun'

require_relative 'brainfuck'

class BrainfuckTest < Minitest::Test
  def subject
    @subject ||= Brainfuck.new(input, output)
  end
  
  def input
    Minitest::Mock.new
  end
  
  def output
    Minitest::Mock.new
  end
  
  def test_greater_than_sign_increments_the_pointer
    expect_output(0)
    
    subject.execute_code("+>.")
    
    verify_output
  end
  
  def test_less_than_sign_decrements_the_pointer
    expect_output(1)
    
    subject.execute_code("+><.")
    
    verify_output
  end
  
  def test_plus_sign_increments_current_cell_value
    expect_output(1)
    
    subject.execute_code("+.")
    
    verify_output
  end
  
  def test_minus_sign_decrements_current_cell_value
    expect_output(1)
    
    subject.execute_code("++-.")
    
    verify_output
  end
  
  def test_dot_outputs_value_of_the_current_cell
    expect_output(1)
    
    subject.execute_code("+.")
    
    verify_output
  end
  
  def test_comma_reads_value_into_the_current_cell
    expect_input(1)
    expect_output(1)
    
    subject.execute_code(",.")
    
    verify_input
    verify_output
  end
  
  def test_brackets_create_a_cycle
    expect_output(3)
    
    subject.execute_code("+++[>+<-]>.")

    verify_output
  end

  private
  
  def expect_input(ret_val)
    subject.input.expect(:gets, ret_val)
  end
  
  def expect_output(*args)
    subject.output.expect(:puts, nil, args)
  end
  
  def verify_input
    subject.input.verify
  end
  
  def verify_output
    subject.output.verify
  end
end
