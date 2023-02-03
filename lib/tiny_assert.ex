defmodule TinyAssert do
  @moduledoc """
    inlined assertions

    todo:
  • Implement assert for every operator in Elixir. • Add Boolean assertions, such as assert true.
  • Implement a refute macro for refutations.
  • Run test cases in parallel within Assertion.Test.run/2 via spawned processes.
  • Add reports for the module. Include pass/fail counts and execution time.
  """

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute(__MODULE__, :tests, accumulate: true)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def run do
        IO.puts "Running the tests (#{inspect(@tests)})"
      end
    end
  end

  defmacro test(description, do: test_block) do
    test_func = String.to_atom(description)

    quote do
      @tests {unquote(test_func), unquote(description)}
      def unquote(test_func)(), do: unquote(test_block)
    end
  end

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
