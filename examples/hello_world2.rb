require_relative '../brainfuck'
require_relative '../ascii_encoding'

brainfuck = Brainfuck.new(Brainfuck::IO.new(ASCIIEncoding.new))

brainfuck.execute_code(
  ">++++++++[-<+++++++++>]<.>[][<-]>+>++>++>+++[>[->+++<<+++>]<<]>-----.
   >>+++..+++.>-.<<[>[+>+]>>]<--------------.>>.+++.------.--------.>+.>+."
)
