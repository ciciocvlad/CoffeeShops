defmodule CoffeeShopsWeb.Utils.CoffeeShops do
  @moduledoc false

  import CoffeeShopsWeb.Utils.Strings

  @url "https://static.reasig.ro/interview/coffee_shops_exerceise/coffee_shops.csv"

  def get_closest_coffee_shops(x, y) do
    current_loc = {to_float!(x), to_float!(y)}

    with {:ok, response} <- HTTPoison.get(@url),
         200 <- response.status_code do
      {:ok,
       response.body
       |> String.split("\n")
       |> Enum.reduce({current_loc, []}, &validate/2)
       |> elem(1)}
    else
      _ -> {:error, "Cannot read CSV data"}
    end
  rescue
    _ -> {:error, "Malformed data"}
  end

  defp validate(value, {current_loc, [fst, snd, trd]} = acc) do
    {name, x, y} = validate_row(value)
    new = %{name: name, location: %{x: x, y: y}, distance: find_distance({x, y}, current_loc)}

    if new.distance < trd.distance do
      {current_loc, Enum.sort_by([fst, snd, new], &Map.get(&1, :distance))}
    else
      acc
    end
  end

  defp validate(value, {current_loc, arr}) do
    {name, x, y} = validate_row(value)
    new = %{name: name, location: %{x: x, y: y}, distance: find_distance({x, y}, current_loc)}
    {current_loc, Enum.sort_by([new | arr], &Map.get(&1, :distance))}
  end

  defp validate_row(str) do
    [name, x, y] = String.split(str, ",")
    {name, to_float!(x), to_float!(y)}
  end

  defp find_distance({x1, y1}, {x2, y2}),
    do: :math.sqrt(((x2 - x1) * 111.32) ** 2 + ((y2 - y1) * 82.3) ** 2)
end
