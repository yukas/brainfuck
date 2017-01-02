require_relative '../brainfuck'
require_relative '../ascii_encoding'

brainfuck = Brainfuck.new(STDIN, STDOUT, ASCIIEncoding.new)

brainfuck.execute_code(
  "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..
   +++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>."
)