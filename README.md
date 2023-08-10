# Recurse

[![hex.pm](https://img.shields.io/hexpm/v/recurse.svg)](https://hex.pm/packages/recurse)
[![hex.pm](https://img.shields.io/hexpm/dt/recurse.svg)](https://hex.pm/packages/recurse)
[![hex.pm](https://img.shields.io/hexpm/l/recurse.svg)](https://hex.pm/packages/recurse)
[![hexdocs.pm](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/recurse)


Explicit recursion inside functions with a recursive block.

## Installation

The package can be installed by adding `recurse` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:recurse, "~> 0.1.0"}
  ]
end
```

## Usage

Without Recurse, a tail-recursive definition of reverse could be written like this:

```elixir
def reverse(list), do: do_reverse(list, [])

defp do_reverse([], acc), do: acc
defp do_reverse([head | tail], acc) do
  do_reverse(tail, [head | acc])
end
```

With Recurse, you could do it like this:

```elixir
def reverse(list) do
  recurse on list, [] do
    [], acc -> acc
    [head | tail], acc -> recurse tail, [head | acc]
  end
end
```

## License

Recurse is released under the GPL-3.0 license - see the [LICENSE](LICENSE) file.
