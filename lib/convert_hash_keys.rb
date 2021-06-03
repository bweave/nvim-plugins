require "neovim/logging"

class ConvertHashKeys
  include Neovim::Logging

  def initialize(to:, buffer:, starting:, ending:)
    @to = to.to_sym
    @buffer = buffer
    @starting = starting
    @ending = ending
    @lines = buffer.get_lines(starting, ending, false)
    log(:debug) { {lines: lines} }
  end

  def call
    buffer.set_lines(starting, ending, false, replacements)
  end

  private

  attr_reader :to
  attr_reader :buffer
  attr_reader :starting
  attr_reader :ending
  attr_reader :lines

  def replacements
    case to
    when :string
      lines.map {|line| line.gsub(/(\w+): /, '"\1" => ') }
    when :symbol
      lines.map {|line| line.gsub(/"(\w+)" => /, '\1: ') }
    else
      raise "Don't know how to convert to #{to}"
    end
  end
end
