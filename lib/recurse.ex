defmodule Recurse do
  @moduledoc """
  Recurse module.
  """

  @doc """
  Recursively matches the given expression against the given clauses.

  ## Examples

      iex> recurse 'example' do
      ...>   [] -> 0
      ...>   [_ | tail] -> 1 + recurse tail
      ...> end
      7

      iex> recurse reverse('example', []) do
      ...>   [], acc -> acc
      ...>   [head | tail], acc -> reverse(tail, [head | acc])
      ...> end
      ~c"elpmaxe"

  """
  defmacro recurse({call, _, args}, do: block) do
    quote do
      do_recurse = unquote(make_fn(call, block))
      do_recurse.(unquote(args), do_recurse)
    end
  end

  defmacro recurse(arg, do: block) do
    quote do
      do_recurse = unquote(make_fn(block))
      do_recurse.(unquote(arg), do_recurse)
    end
  end

  defp make_fn(expression) do
    expression
    |> Enum.map(fn
      {:->, meta, [args | expression]} ->
        {:->, meta, [args ++ [{:do_recurse, [], Elixir}] | expression]}

      x ->
        x
    end)
    |> Macro.prewalk(fn
      {:recurse, meta, args} ->
        {{:., meta, [{:do_recurse, [], Elixir}]}, [], args ++ [{:do_recurse, [], Elixir}]}

      x ->
        x
    end)
    |> (&{:fn, [], &1}).()
  end

  defp make_fn(call, expression) do
    expression
    |> Enum.map(fn
      {:->, meta, [args | expression]} ->
        {:->, meta, [[args] ++ [{:do_recurse, [], Elixir}] | expression]}

      x ->
        x
    end)
    |> Macro.prewalk(fn
      {^call, meta, args} ->
        {{:., meta, [{:do_recurse, [], Elixir}]}, [], [args] ++ [{:do_recurse, [], Elixir}]}

      x ->
        x
    end)
    |> (&{:fn, [], &1}).()
  end
end
