class IO
  attr_reader :encoding
  
  INPUT  = STDIN
  OUTPUT = STDOUT
  
  def initialize(encoding)
    @encoding = encoding
  end
  
  def input
    encoding.decode(INPUT.gets.chomp)
  end
  
  def output(value)
    OUTPUT.print(encoding.encode(value))
  end
end
