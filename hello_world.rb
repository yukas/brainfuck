require_relative 'brainfuck'

brainfuck = Brainfuck.new(STDIN, STDOUT)

brainfuck.execute_code(
  "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>."
)