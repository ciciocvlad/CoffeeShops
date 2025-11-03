defmodule CoffeeShopsWeb.Utils.Strings do
  @moduledoc """
    Utils module for manipulating strings
  """

  def to_float!(x) when is_binary(x), do: String.to_float(x)
  def to_float!(x) when is_float(x) or is_integer(x), do: x
  def to_float!(_), do: raise("Malformed data")
end
