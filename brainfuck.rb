require "minitest/autorun"

class BrainfuckTest < Minitest::Test
  def subject
    Brainfuck.new
  end
  
  def test_size_of_memory_is_less_than_30000_bytes
    assert_equal 30_000, Brainfuck::MEMORY_SIZE
  end
  
  def test_memory_is_initialized_to_zero
    assert_equal 0, subject.value_at_offset(29_999) 
  end
end

class Brainfuck
  MEMORY_SIZE = 30_000
  
  def value_at_offset(offset)
    0
  end
end