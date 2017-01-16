# frozen_string_literal: true

module Brainfuck
  # As soon as brainfuck works with numbers and we do need to display characters
  # to user we use `ASCIIEncoding` to convert numbers to characters and otherwise
  #
  class ASCIIEncoding
    def encode(val)
      val.chr
    end

    def decode(val)
      val.ord
    end
  end
end
