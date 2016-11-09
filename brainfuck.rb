require "minitest/autorun"

class BrainfuckTest < Minitest::Test
  def test_size_of_brainfuck_interpreter_memory_is_less_than_30000_cells
    assert_equal Brainfuck::MEMORY_SIZE, 30_000
  end
end

class Brainfuck
  MEMORY_SIZE = 30_000
end