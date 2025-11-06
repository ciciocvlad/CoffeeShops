defmodule CoffeeShopsWeb.Utils.Strings do
  @moduledoc """
    Utils module for manipulating strings
  """

  def to_float(x) when is_binary(x), do: {:ok, String.to_float(x)}
  def to_float(x) when is_float(x) or is_integer(x), do: {:ok, x}
  def to_float(_), do: {:error, "Wrong value type"}
end
