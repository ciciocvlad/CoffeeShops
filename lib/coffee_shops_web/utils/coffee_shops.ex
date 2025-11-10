defmodule CoffeeShopsWeb.Utils.CoffeeShops do
  @moduledoc false

  import CoffeeShopsWeb.Utils.Strings

  alias CoffeeShops.Contexts.CoffeeShops

  def get_closest_coffee_shops(x, y) do
    with {:ok, coffee_shops} <- CoffeeShops.list_coffee_shops(),
         {:ok, x} <- to_float(x),
         {:ok, y} <- to_float(y) do
      {:ok,
       coffee_shops
       |> String.split("\n")
       |> Enum.reduce({{x, y}, []}, &validate/2)}
    else
      response -> response
    end
  end

  defp validate(_, {:error, _} = e), do: e

  defp validate(value, {current_loc, [fst, snd, trd]} = acc) do
    with {:ok, {name, x, y}} <- validate_row(value) do
      new = %{name: name, location: %{x: x, y: y}, distance: find_distance({x, y}, current_loc)}

      if new.distance < trd.distance do
        {current_loc, Enum.sort_by([fst, snd, new], &Map.get(&1, :distance))}
      else
        acc
      end
    else
      error -> error
    end
  end

  defp validate(value, {current_loc, arr}) do
    with {:ok, {name, x, y}} <- validate_row(value) do
      new = %{name: name, location: %{x: x, y: y}, distance: find_distance({x, y}, current_loc)}
      {current_loc, Enum.sort_by([new | arr], &Map.get(&1, :distance))}
    else
      error -> error
    end
  end

  defp validate_row(str) do
    [name, x, y] = String.split(str, ",")

    with {:ok, x} <- to_float(x), {:ok, y} <- to_float(y) do
      {:ok, {name, x, y}}
    else
      error -> error
    end
  rescue
    _ -> {:error, "Malformed data"}
  end

  defp find_distance({x1, y1}, {x2, y2}),
    do: :math.sqrt(((x2 - x1) * 111.32) ** 2 + ((y2 - y1) * 82.3) ** 2)
end
