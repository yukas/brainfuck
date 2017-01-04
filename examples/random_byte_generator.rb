require_relative '../brainfuck'
require_relative '../ascii_encoding'

brainfuck = Brainfuck.new(Brainfuck::IO.new(ASCIIEncoding.new))

brainfuck.execute_code(
  <<EOF
  >>>++[
      <++++++++[
          <[<++>-]>>[>>]+>>+[
              -[->>+<<<[<[<<]<+>]>[>[>>]]]
              <[>>[-]]>[>[-<<]>[<+<]]+<<
          ]<[>+<-]>>-
      ]<.[-]>>
  ]
  "Random" byte generator using the Rule 30 automaton.
  Doesn't terminate; you will have to kill it.
  To get x bytes you need 32x+4 cells.
  Turn off any newline translation!
  Daniel B Cristofani (cristofdathevanetdotcom)
  http://www.hevanet.com/cristofd/brainfuck/
EOF
)
