defmodule TinyAssert do
  @moduledoc """
    Rust style inlined assertions
  """

  defmacro assert({operator}, _, [lhs, rhs]) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      assertion(operator, lhs, rhs)
    end
  end

  def assertion(:==, lhs, rhs) do
    cond do
      lhs == rhs ->
        IO.write(".")

      true ->
        IO.puts("""
           -- FAILURE --
           Expected: #{lhs}
           To equal: #{rhs}
        """)
    end
  end

  def assertion(:>, lhs, rhs) do
    cond do
      lhs > rhs ->
        IO.write(".")

      true ->
        IO.puts("""
           -- FAILURE --
           Expected: #{lhs}
           To be greater than : #{rhs}
        """)
    end
  end

  def assertion(:<, lhs, rhs) do
    cond do
      lhs < rhs ->
        IO.write(".")

      true ->
        IO.puts("""
           -- FAILURE --
           Expected: #{lhs}
           To be less than: #{rhs}
        """)
    end
  end
end
