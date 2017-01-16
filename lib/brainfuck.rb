require 'brainfuck/version'
require 'brainfuck/interpreter'
require 'brainfuck/ascii_encoding'
require 'brainfuck/io'
require 'brainfuck/fatal_error'

module Brainfuck
  # Temporarily wrapper around Interpreter class
  #
  class Wrapper
    attr_reader :io

    def initialize(io)
      @io = io
    end

    def execute_code(code)
      Interpreter.new(code, io).run
    end
  end
end
