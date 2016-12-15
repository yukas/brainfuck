require 'minitest/autorun'

require_relative '../ascii_encoding'

class ASCIIEncodingTest < Minitest::Test
  def subject
    @subject ||= ASCIIEncoding.new
  end
  
  def test_encodes_number_to_symbol
    assert_equal "!", subject.encode(33)
  end
  
  def test_decodes_number_to_symbol
    assert_equal 33, subject.decode("!")
  end
end