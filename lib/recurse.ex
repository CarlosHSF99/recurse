defmodule Recurse do
  @moduledoc """
  Recurse module.
  """

  @doc """
  Recursively matches the given expression against the given clauses.

  ## Examples

      iex> recurse on 'example' do
      ...>   [] -> 0
      ...>   [_ | tail] -> 1 + recurse tail
      ...> end
      7

  """
  defmacro recurse({:on, _, args}, do: block) do
    quote do
      do_recurs = unquote(make_fn(block))
      do_recurs.(unquote(args), do_recurs)
    end
  end

  defp make_fn(expression) do
    expression
    |> Enum.map(fn
      {:->, meta, [args | expression]} ->
        {:->, meta, [[args] ++ [{:do_recurse, [], Elixir}] | expression]}

      x ->
        x
    end)
    |> Macro.prewalk(fn
      {:recurse, meta, args} ->
        {{:., meta, [{:do_recurse, [], Elixir}]}, [], [args] ++ [{:do_recurse, [], Elixir}]}

      x ->
        x
    end)
    |> (&{:fn, [], &1}).()
  end
end
