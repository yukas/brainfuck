require 'brainfuck/version'
require 'brainfuck/interpreter'
require 'brainfuck/ascii_encoding'
require 'brainfuck/io'
require 'brainfuck/fatal_error'

class Brainfuck # rubocop:disable Style/Documentation
  attr_reader :io, :encoding

  def initialize(io)
    @io = io
  end

  def execute_code(code)
    Interpreter.new(code, io).run
  end
end
