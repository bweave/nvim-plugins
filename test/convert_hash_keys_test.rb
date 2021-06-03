require "test_helper"
require_relative "../lib/convert_hash_keys"

FakeBuffer = Struct.new(:lines) do
  def get_lines starting, ending, strict_indexing
    lines
  end

  def set_lines starting, ending, strict_indexing, replacement
    replacement
  end
end

class ConvertHashKeysTest < Minitest::Test
  test "converting string keys to symbol keys" do
    lines ||= [
      "{",
      "  \"foo\" => \"fuzz\"",
      "  \"bar\" => \"baz\"",
      "}"
    ]
    subject = ConvertHashKeys.new(
      to: :symbol,
      buffer: FakeBuffer.new(lines),
      starting: 0,
      ending: 2,
    )

    expected = [
      "{",
      "  foo: \"fuzz\"",
      "  bar: \"baz\"",
      "}"
    ]

    assert_equal expected, subject.call
  end

  test "converting symbol keys to string keys" do
    lines = [
      "{",
      "  foo: \"fuzz\"",
      "  bar: \"baz\"",
      "}"
    ]
    subject = ConvertHashKeys.new(
      to: :string,
      buffer: FakeBuffer.new(lines),
      starting: 0,
      ending: 3,
    )
    expected = [
      "{",
      "  \"foo\" => \"fuzz\"",
      "  \"bar\" => \"baz\"",
      "}"
    ]

    assert_equal expected, subject.call
  end
end
