require"neovim"
require_relative "lib/convert_hash_keys"

Neovim.plugin do |plug|
  plug.command(:HashKeysToString, range: true) do |nvim, starting, ending|
    ConvertHashKeys.new(
      to: :string,
      buffer: nvim.current.buffer,
      starting: starting - 1,
      ending: ending
    ).call
  end

  plug.command(:HashKeysToSymbol, range: true) do |nvim, starting, ending|
    ConvertHashKeys.new(
      to: :symbol,
      buffer: nvim.current.buffer,
      starting: range_start - 1,
      ending: ending
    ).call
  end
end

